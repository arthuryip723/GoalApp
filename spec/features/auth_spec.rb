require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content "Create a New User"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in "Username", with: 'arthur'
      fill_in "Password", with: 'arthur'
      click_button 'Sign Up'
      expect(page).to have_content "arthur"
    end

  end


end

feature "logging in" do
  before :each do
    visit "/session/new"
  end
  it "shows username on the homepage after login" do
    sign_up_as_arthur
    sign_in("arthur")
    # fill_in "Username", with: 'arthur'
    # fill_in "Password", with: 'arthur'
    # click_button 'Sign In'
    # save_and_open_page
    expect(page).to have_content "arthur"
  end

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
