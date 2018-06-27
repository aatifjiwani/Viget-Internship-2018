class UsersController < ApplicationController
  include LocationHelper
  
  def new 
    @page_title = "Create Account | Haxxor News"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:location]
      api_request = HTTP.get(location_api_url).as_json
      @user.location = get_only_location(JSON.parse(api_request["body"][0]))
    end
    
    if @user.save
      @user.regenerate_password_token
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :profile_img)
  end
end
