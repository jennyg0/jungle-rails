require 'rails_helper'

RSpec.feature "User can login and redirects to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create! name: "username", email: "test@test.com", password: "password", password_confirmation: "password"

  end

scenario "user logs in" do
  visit login_path
  
  save_screenshot('4a.png')
  fill_in 'email', with: 'test@test.com'
  fill_in 'password', with: 'password'
  click_on 'Submit'
  sleep(1)
  save_screenshot('4b.png')

  expect(page).to have_text 'Products'
  expect(page).to have_text 'Signed in as username'
  expect(page).to have_text 'Logout'
end
end