require 'spec_helper'
require 'rails_helper'

feature "Creating a Comments" do
  context "on a goal" do
    before :each do
      sign_up("arthur")
      visit "/goals"
      make_goal("testing goal", "Public")
      click_link("testing goal")
    end

    it "shows a comment page" do
      expect(page).to have_content "Comments"
    end

    it "has a comment creating functionality" do
      expect(page).to have_button "Add Comment"
    end

    it "creates and adds a comment to the page" do
      make_comment("Wow this is such a great comment")
      expect(page).to have_content "Wow this is such a great comment"
    end

    it "builds on other comments" do
      make_comment("Wow this is such a great comment")
      make_comment("Second comment!")
      expect(page).to have_content "Wow this is such a great comment"
      expect(page).to have_content "Second comment!"
    end
  end

  context "on a user" do
    before :each do
      sign_up("arthur")
      click_link("Go to my Goals")
    end

    it "shows a comment box" do
      expect(page).to have_content "Comments"
    end

    it "has a comment creating functionality" do
      expect(page).to have_button "Add Comment"
    end

    it "creates and adds a comment to the page" do
      make_comment("Wow this is such a great comment")
      expect(page).to have_content "Wow this is such a great comment"
    end

    it "builds on other comments" do
      make_comment("Wow this is such a great comment")
      make_comment("Second comment!")
      expect(page).to have_content "Wow this is such a great comment"
      expect(page).to have_content "Second comment!"
    end
  end
end
