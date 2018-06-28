class PasswordResetsController < ApplicationController
  def new
    @page_title = "Reset Password | Haxxor News"
  end
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.bypass_creation = true;
      @user.regenerate_password_token
      flash[:notice] = "We've sent a reset password link to the given email."
      PasswordResetMailer.with(user: @user, token: @user.password_token).reset_email.deliver_later
      redirect_to new_password_reset_path
    else
      flash[:alert] = "No account was found with the given email."
      redirect_to new_password_reset_path
    end
  end
  
  def edit
    @page_title = "Reset Password | Haxxor News"
    @user = User.find_by(password_token: params[:token], email: params[:email])
    
    
    if @user and calc_time(@user.updated_at.to_datetime)
      session[:user_id] = @user.id
    else
      flash[:alert] = "Password reset session has expired. Please try again."
      redirect_to new_password_reset_path
    end
  end
  
  def update
    @user = User.find(session[:user_id])
    if @user.update(reset_params)
      @user.regenerate_password_token
      reset_session
      flash[:notice] = "Successfully updated password."
      @user.bypass_creation = false;
      redirect_to new_sessions_path
    else
      flash[:alert] = "Passwords do not match. Try again."
      redirect_to edit_password_reset_path(token: @user.password_token, email: @user.email)
    end
  end
  
  private
  def reset_params
    params.permit(:password, :password_confirmation)
  end
  
  def calc_time(updated_time)
    ((DateTime.now - updated_time) * 24).to_i <= 6
  end
    
end
