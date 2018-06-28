require 'open-uri'
class SessionsController < ApplicationController
  def new
    @page_title = 'Sign In | Haxxor News'
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def redirect
    @response = auth_hash
    
    if @response["provider"] == "facebook"
      info = @response["info"]
      user_params = {
        username: create_username(info["name"]),
        email: info["email"]
        }
      @profile_img = grab_image(info["image"])
    end
    
    binding.pry
    
    @user = User.new(user_params.merge(password: "secret"))
    if @profile_img
      @user.profile_img.attach(io: @profile_img, filename: "#{user_params[:username]}profileimg.jpeg")
    end
    
    binding.pry
    
    if @user.save
      binding.pry
      session[:user_id] = @user.id
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
