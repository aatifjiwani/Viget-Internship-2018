require 'open-uri'
class SessionsController < ApplicationController
  def new
    @page_title = 'Sign In | Haxxor News'
  end

  def create
    @oauth = CheckUser.new.check_oauth_name(params[:username]) 
    if !@oauth
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to articles_path
      else
        flash[:alert] = "Invalid username or password."
        redirect_to new_sessions_path
      end
    else
      flash[:alert] = "#{@oauth.user.username}, please sign in using #{@oauth.provider.capitalize}"
      redirect_to new_sessions_path
    end
  end

  def redirect
    @response = auth_hash
    info = @response["info"]
    
    #Checking whether the user from provider has already been created thus bypassing everything
    @oauth = CheckUser.new.check_oauth_email(info["email"])
    if !@oauth
      user_params = OauthInfo.new.getinfo(@response["provider"], info)
      @profile_img = OauthInfo.new.getimg(info)
      
      #Checking whether or not the user already exists based on given parameters from provider
      if !CheckUser.new.check_native_user(user_params[:username], user_params[:email])
        @user = User.new(user_params)
        @user.oauth_creation = true
        if @profile_img
          @user.profile_img.attach(io: @profile_img, filename: "#{user_params[:username]}profileimg.jpeg")
        end
                
        if @user.save
          @user.create_o_auth_user(provider: @response["provider"])
          session[:user_id] = @user.id
          @user.oauth_creation = false
          redirect_to articles_path
        end
      else
        flash[:alert] = "User already exists. Please sign in natively."
        redirect_to new_sessions_path
      end
    else
      session[:user_id] = @oauth.user.id
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
end
