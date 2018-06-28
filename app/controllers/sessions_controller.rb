require 'open-uri'
class SessionsController < ApplicationController
  def new
    @page_title = 'Sign In | Haxxor News'
  end

  def create
    @oauth = OAuthUser.where(username: params[:username]).first 
    unless @oauth
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to articles_path
      else
        flash[:alert] = "Invalid username or password."
        redirect_to new_sessions_path
      end
    else
      flash[:alert] = "#{@oauth.username}, please sign in using #{@oauth.provider.capitalize}"
      redirect_to new_sessions_path
    end
  end

  def redirect
    @response = auth_hash
    info = @response["info"]
    @oauth = OAuthUser.where(email: info["email"]).first
    
    unless @oauth
      if @response["provider"] == "facebook"
        user_params = {
          username: create_username(info["name"]),
          email: info["email"]
          }
        @profile_img = grab_image(info["image"])
      end

      @user = User.new(user_params)
      @user.oauth_creation = true
      if @profile_img
        @user.profile_img.attach(io: @profile_img, filename: "#{user_params[:username]}profileimg.jpeg")
      end
      
      if @user.save
        OAuthUser.create(username: @user.username, email: @user.email, provider: @response["provider"])
        session[:user_id] = @user.id
        @user.oauth_creation = false
        redirect_to articles_path
      end
    else
      session[:user_id] = User.where(email: @oauth.email).first.id
      flash[:notice] = "Signed in!"
      redirect_to articles_path
    end
  end


  def destroy
    reset_session
    redirect_to articles_path
  end
  
  private
  def auth_hash
    request.env['omniauth.auth']
  end
    
  def create_username(full_name)
    user = full_name.split(" ")
    case user.length
      when 1
        full_name.downcase
      when 2
        full_name.gsub(" ", "").downcase
    else
      "#{user.first.downcase}#{user.last.downcase}"
    end
  end
  
  def grab_image(url)
    downloaded_image = open(url)
  end
end
