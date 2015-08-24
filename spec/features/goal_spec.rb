require 'spec_helper'
require 'rails_helper'

feature "Creating a Goal" do
  context "when signed in" do
    before :each do
      sign_up("arthur")
      visit "/goals"
    end

    it "has a link to create a new goal" do
      expect(page).to have_link "Create a Goal"
    end

    it "should seperate private and public goals" do
      expect(page).to have_content "Public"
      expect(page).to have_content "Private"
    end

    it "hides private goals from other users" do
      make_goal("this is arthurs private goal", "Private")
      sign_out
      sign_up("derek")
      expect(page).not_to have_content "this is arthurs private goal"
    end

    it "has a button to complete the incomplete goals" do
      make_goal("this is arthurs private goal", "Private")
      expect(page).to have_button "Complete"
    end

    it "changes the status to 'complete' when you press the Complete button" do
      make_goal("this is arthurs private goal", "Private")
      click_button('Complete')
      expect(page).to have_content "this is arthurs private goal, status: complete"
    end
  end

  context "when signed out" do
    it "redirects you to the sign in page" do
      sign_up("arthur")
      sign_out
      visit "/goals"
      expect(page).to have_content "Sign In"
    end
  end
end
