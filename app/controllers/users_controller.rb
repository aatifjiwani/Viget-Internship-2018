class UsersController < ApplicationController
  def new 
    @page_title = "Create Account | Haxxor News"
    @user = User.new
  end

  def create
    #binding.pry
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
    
  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '134.201.250.155'
    else
      request.remote_ip
    end
  end
  
  def get_only_location(json_object)
    json_object.slice("country_name", "city", "latitude", "longitude")
  end
  
  def location_api_url
    "http://api.ipstack.com/#{remote_ip}?access_key=#{Rails.application.credentials.dig(:geolocation_api_key)}"
  end
end
