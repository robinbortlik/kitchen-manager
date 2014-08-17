require 'spec_helper'

describe "users", :request => true, :js =>true do
  let(:user) {FactoryGirl.create(:user, organization_unit_id: organization_unit.id)}
  let(:organization_unit) {FactoryGirl.create(:organization_unit)}

  it "create user" do
    organization_unit
    visit_admin
    click_on "Users"
    page.find("button", text: "New").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='First Name']").set "Robin"
    page.find(:css, "input[placeholder='Last Name']").set "Bortlik"
    page.find(:css, "select").set organization_unit.id

    expect{click_on "Save"; wait_for_ajax}.to change{User.count}.by(1)
    within "table" do
      expect(page).to have_content "Robin"
    end
  end

  it "edit user" do
    user
    visit_admin
    click_on "Users"
    expect(page).to have_content "Zavadsky Alex"
    page.find(:css, "span.glyphicon-pencil").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='First Name']").set "Robin"
    page.find(:css, "input[placeholder='Last Name']").set "Bortlik"
    expect{click_on "Save"; wait_for_ajax}.to change{User.last.name}.from("Zavadsky Alex").to("Bortlik Robin")
    within "table" do
      expect(page).to have_content "Bortlik Robin"
    end
  end

  it "mark as deleted" do
    user
    visit_admin
    click_on "Users"
    expect{page.find(:css, "span.glyphicon-trash").click; wait_for_ajax}.to change{User.last.deleted}.from(nil).to(true)
  end

  it "unmark as deleted" do
    user.deleted = true
    user.save!
    visit_admin
    click_on "Users"
    expect{page.find(:css, "span.glyphicon-refresh").click; wait_for_ajax}.to change{User.last.deleted}.from(true).to(false)
  end
end