def login_user(user)
  visit new_sessions_path
  fill_in "Username:", with: user.username
  fill_in "Password:", with: user.password
  click_button 'Sign In'
end
