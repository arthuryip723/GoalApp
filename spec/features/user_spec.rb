require 'spec_helper'
require 'rails_helper'

feature "User show page" do
  before :each do
    sign_up("arthur")
    make_goal("testing goal", "Public")
    click_link("Go to my Goals")
  end

  it "shows my goals" do
    expect(page).to have_content "My Goals"
  end

  it "has a create goals link" do
    expect(page).to have_link "Create a Goal"
  end

  it "only shows my goals" do
    sign_out
    sign_up("derekc")
    make_goal("will this show up?", "Public")
    sign_out
    sign_in("arthur")
    click_link("Go to my Goals")
    expect(page).not_to have_content "will this show up?"
  end
end
