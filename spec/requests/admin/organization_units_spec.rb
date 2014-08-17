require 'spec_helper'

describe "organization units", :request => true, :js =>true do

  let(:organization_unit) {FactoryGirl.create(:organization_unit, position: 1)}

  it "create organization unit" do
    organization_unit
    visit_admin
    click_on "Organization Units"
    page.find("button", text: "New").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='Name']").set "organization unit 1"
    page.find(:css, "input[placeholder='Position (number)']").set "1"
    expect{click_on "Save"; wait_for_ajax}.to change{OrganizationUnit.count}.by(1)
    within "table" do
      expect(page).to have_content "organization unit 1"
    end
  end

  it "edit organization unit" do
    organization_unit
    visit_admin
    click_on "Organization Units"
    expect(page).to have_content "Brno"
    page.find(:css, "span.glyphicon-pencil").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='Name']").set "Praha"

    expect{click_on "Save"; wait_for_ajax}.to change{OrganizationUnit.last.name}.from("Brno").to("Praha")
    within "table" do
      expect(page).to have_content "Praha"
    end
  end

  it "delete" do
    user = FactoryGirl.create(:user, organization_unit_id: organization_unit.id)
    visit_admin
    click_on "Organization Units"
    expect{page.find(:css, "span.glyphicon-trash").click; wait_for_ajax}.to change{OrganizationUnit.count}.by(-1)
    expect(user.reload.organization_unit_id).to be_nil
  end

end