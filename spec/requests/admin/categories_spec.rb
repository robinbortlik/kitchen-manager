require 'spec_helper'

describe "categories", :request => true, :js =>true do

  let(:category) {FactoryGirl.create(:category, position: 1)}

  it "create" do
    category
    visit_admin
    click_on "Categories"
    page.find("button", text: "New").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='Name']").set "category 1"
    page.find(:css, "input[placeholder='Position (number)']").set "1"
    expect{click_on "Save"; wait_for_ajax}.to change{Category.count}.by(1)
    within "table" do
      expect(page).to have_content "category 1"
    end
  end

  it "edit" do
    category
    visit_admin
    click_on "Categories"
    expect(page).to have_content "Dinner"
    page.find(:css, "span.glyphicon-pencil").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='Name']").set "Breakfast"

    expect{click_on "Save"; wait_for_ajax}.to change{Category.last.name}.from("Dinner").to("Breakfast")
    within "table" do
      expect(page).to have_content "Breakfast"
    end
  end

  it "delete" do
    product = FactoryGirl.create(:product, category_id: category.id)
    visit_admin
    click_on "Categories"
    expect{page.find(:css, "span.glyphicon-trash").click; wait_for_ajax}.to change{Category.count}.by(-1)
    expect(product.reload.category_id).to be_nil
  end

end