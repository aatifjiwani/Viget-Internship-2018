class PasswordResetMailer < ApplicationMailer
  default from: 'nflkiddo.productions@gmail.com'

  def reset_email
    @user = params[:user]
    @token = params[:token]
    mail(to: @user.email, subject: 'Password Reset')
  end
end
