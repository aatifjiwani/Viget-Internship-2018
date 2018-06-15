require 'bcrypt'
class PasswordResetsController < ApplicationController
  def new
    @page_title = "Reset Password | Haxxor News"
  end
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      flash[:notice] = "We've sent a reset password link to the given email."
      PasswordResetMailer.with(user: @user, token: @user.password_token).reset_email.deliver_now
      redirect_to new_password_reset_path
    else
      flash[:alert] = "No account was found with the given email."
      redirect_to new_password_reset_path
    end
  end
  
  def edit
    @page_title = "Reset Password | Haxxor News"
    @user = User.find_by(password_token: params[:token])
    unless @user
      flash[:alert] = "Password reset session has expired. Please try again."
      redirect_to new_password_reset_path
    end
  end
  
  def update
    if params[:password] == params[:password_confirmation]
      @user = User.find(params[:user])
      @user.update(password_digest: BCrypt::Password.create(params[:password]))
      flash[:notice] = "Successfully updated password."
      @user.regenerate_password_token
      redirect_to new_sessions_path
    else
      flash[:alert] = "Passwords do not match. Try again."
      redirect_to edit_password_reset_path(token: @user.password_token)
    end
  end
end
