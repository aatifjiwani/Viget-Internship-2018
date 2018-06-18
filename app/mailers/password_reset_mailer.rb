class PasswordResetMailer < ApplicationMailer
  default from: 'no_reply@haxxornews.com'

  def reset_email
    @user = params[:user]
    @token = params[:token]
    @email = @user.email
    mail(to: @email, subject: 'Haxxor News | Password Reset')
  end
end
