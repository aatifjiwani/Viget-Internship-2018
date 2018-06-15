require 'rails_helper'

RSpec.describe 'User Password Reset', type: :feature do
  describe 'Resetting the user password' do
    context 'With existing user' do
      let!(:user) { login_user(name: 'demouser', email: 'demouser@viget.com') }
      
      before do
        visit new_password_reset_path
      end
      
      it 'cannot reset password for nonexistent user' do
        fill_in 'Email:', with: 'nonexistentuser@viget.com'
        click_on 'Reset Password'
        expect(page).to have_content "No account was found with the given email"
      end
      
      it 'sends reset password email w/ link to existent user' do
        fill_in 'Email:', with: user.email
        click_on 'Reset Password'
        expect(page).to have_content "We've sent a reset password link to the given email." 
        #binding.pry
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries[0].to).to include(user.email)
      end
      
      let!(:user_token) { user.password_token }
      
      it 'allows user to navigate to unique url' do
        visit edit_password_reset_path(token: user_token)
        expect(page).to have_content "Reset Password:"
        expect(page).to have_content "If you remember your password, simply sign in"
      end
      
      it 'allows user to reset password and actually changes it' do 
        visit edit_password_reset_path(token: user_token)
        fill_in "New Password:", with: 'new-secret'
        fill_in "Confirm Password:", with: 'new-secret'
        click_on "Reset Password"
        expect(page).to have_content "Successfully updated password."
        user.reload
        expect(user.authenticate("new-secret")).to eq(user)
      end
      
    end
  end
end