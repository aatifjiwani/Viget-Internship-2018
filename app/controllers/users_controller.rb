class UsersController < ApplicationController
  include LocationHelper
  
  def new 
    @page_title = "Create Account | Haxxor News"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:should_locate]
      @user.location = Geolocater.new(request.remote_ip).location
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
    if @user.location
      latitude = @user.location["latitude"]
      longitude = @user.location["longitude"]
      city = @user.location["city"]
      @image = MapImage.new(latitude, longitude, city).image
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :profile_img)
  end
end
