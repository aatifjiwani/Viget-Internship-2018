class UsersController < ApplicationController
  def new 
    @page_title = "Create Account | Haxxor News"
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :profile_img)
  end

end
