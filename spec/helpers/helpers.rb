module Helpers
  def login_user(name: 'demouser', email: 'demouser@viget.com')
    user = create(:user, username: name, email: email)
    visit new_sessions_path
    fill_in "Username:", with: user.username
    fill_in "Password:", with: user.password
    click_button 'Sign In'
    return user
  end
end