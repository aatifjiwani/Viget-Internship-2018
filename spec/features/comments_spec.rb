require 'rails_helper' 

RSpec.describe 'Posting Comments on Article', type: :feature do
  context "with an existing article from user" do
    before do
      create(:article)
      visit root_url
    end

    it "does not have a space for comments without signed in user" do
      click_link 'Show'
      expect(page).to have_content 'Demo Article'
      expect(page).to_not have_content "Enter comment"
    end
  end

  context "with a signed in user" do
    before(:each) do
      login_user(name: 'testuser', email: 'testuser@viget.com')
      create(:article)
      visit root_url
      click_on 'Show'
      fill_in 'Enter comment:', with: 'Testing a comment'
      click_on 'Reply'
    end

    it 'has a space for comments now' do
      expect(page).to have_content 'Enter comment'
    end

    it 'creates a comment' do
      expect(page).to have_content 'testuser'
      expect(page).to have_content 'Testing a comment'
    end
  end

  context "with an existing comment" do
    def fill_in_ckeditor(locator, params = {})
      # Find out ckeditor id at runtime using its label
      locator = find('label', text: locator)[:for] if page.has_css?('label', text: locator)
      # Fill the editor content
      page.execute_script <<-SCRIPT
var ckeditor = CKEDITOR.instances.#{locator}
ckeditor.setData('#{params[:with]}')
ckeditor.focus()
ckeditor.updateElement()
SCRIPT
    end

    before do
      login_user(name: 'testuser', email: 'testuser@viget.com')
      create(:article)
      visit root_path
      click_on 'Show'
      fill_in_ckeditor 'comment_body', with: 'Testing a comment'
      click_on 'Reply'
    end

    it 'creates nested comments', js: true do
      within(".comment-list") do        
        click_on "Reply"
        expect(page).to have_content "Enter comment"
        fill_in_ckeditor "comment_#{Comment.first.id}", with: 'Testing the nested comment'
        click_on "Reply"
      end
      
      expect(page).to have_content "Testing the nested comment"
    end
  end
end