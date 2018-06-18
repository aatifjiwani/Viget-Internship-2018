require 'rails_helper'


RSpec.describe 'User Password Reset', type: :feature do
  include ActiveJob::TestHelper
  describe 'Resetting the user password' do
    context 'With existing user' do
      let!(:user) { login_user(name: 'demouser', email: 'demouser@viget.com') }

      before do
        clear_enqueued_jobs
        visit new_password_reset_path
      end

      it 'cannot reset password for nonexistent user' do
        fill_in 'Email:', with: 'nonexistentuser@viget.com'
        click_on 'Reset Password'
        expect(page).to have_content "No account was found with the given email"
      end

      it 'sends reset password email w/ link to existent user' do
        fill_in 'Email:', with: user.email
        expect{click_on 'Reset Password'}.to change{enqueued_jobs.size}.by(1)
        expect(page).to have_content "We've sent a reset password link to the given email."
        expect {
          perform_enqueued_jobs do
            PasswordResetMailer.with(user: user, token: user.password_token).reset_email.deliver_later
          end
          }.to change { ActionMailer::Base.deliveries.size }.by(1)
      end

      let!(:user_token) { user.password_token }

      it 'allows user to navigate to unique url' do
        visit edit_password_reset_path(token: user_token, email: user.email)
        expect(page).to have_content "Reset Password:"
        expect(page).to have_content "If you remember your password, simply sign in"
      end

      it 'allows user to reset password and actually changes it' do 
        visit edit_password_reset_path(token: user_token, email: user.email)
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