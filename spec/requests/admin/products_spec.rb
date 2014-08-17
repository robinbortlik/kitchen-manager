require 'spec_helper'

describe "products", :request => true, :js =>true do

  let(:product) {FactoryGirl.create(:product, price: 2, position: 1, category_id: category.id)}
  let(:category) {Category.first || FactoryGirl.create(:category)}

  it "create product" do
    category
    visit_admin
    click_on "Products"
    page.find("button", text: "New").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='Name']").set "Product 1"
    page.find(:css, "input[placeholder='Price']").set "10"
    page.find(:css, "input[placeholder='Position (number)']").set "1"
    page.find(:css, "select").set category.id
    expect{click_on "Save"; wait_for_ajax}.to change{Product.count}.by(1)
    within "table" do
      expect(page).to have_content "Product 1"
      expect(page).to have_content "10"
    end
  end

  it "edit product" do
    product
    visit_admin
    click_on "Products"
    expect(page).to have_content "Banana"
    page.find(:css, "span.glyphicon-pencil").click
    expect(page).to have_selector(".modal-content")
    page.find(:css, "input[placeholder='Name']").set "new Apple"
    page.find(:css, "select").set category.id
    expect{click_on "Save"; wait_for_ajax}.to change{Product.last.name}.from("Banana").to("new Apple")
    within "table" do
      expect(page).to have_content "new Apple"
    end
  end

  it "mark as deleted" do
    product
    visit_admin
    click_on "Products"
    expect{page.find(:css, "span.glyphicon-trash").click; wait_for_ajax}.to change{Product.last.deleted}.from(nil).to(true)
  end

  it "unmark as deleted" do
    product.deleted = true
    product.save!
    visit_admin
    click_on "Products"
    expect{page.find(:css, "span.glyphicon-refresh").click; wait_for_ajax}.to change{Product.last.deleted}.from(true).to(false)
  end

end