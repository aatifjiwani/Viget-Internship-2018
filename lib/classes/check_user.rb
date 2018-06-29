class CheckUser
  def check_oauth_email(email)
    User.check_email(email).first ? User.check_email(email).first.o_auth_user : nil
  end
  
  def check_oauth_name(name)
    User.check_name(name).first ? User.check_name(name).first.o_auth_user : nil
  end
  
  def check_native_user(username, email)
    User.check_name(username).first || User.check_email(email).first
  end
end