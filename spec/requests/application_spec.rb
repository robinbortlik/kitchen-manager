require 'spec_helper'

describe Application do

  let(:user) {FactoryGirl.create(:user)}
  let(:product) {FactoryGirl.create(:product, price: 2)}
  let(:category) {Category.first || FactoryGirl.create(:category)}
  let(:product_user) {ProductUser.create(user_id: user.id, product_id: product.id, price: 30)}

  before(:each) do
    user
    product
  end

  it 'get home page', :request => true, :js =>true do
    visit '/'
    page.should have_selector("#ember-app")
  end

  it 'display users', :request => true, :js =>true do
    visit '/'
    page.should have_content(user.name)
  end

  it 'order food', :request => true, :js =>true do
    visit '/'
    page.find("h5", text: user.name).click
    page.find("a", text: category.name).click
    page.find("h5", text: product.name).click
    page.find("h5", text: product.name).click
    expect(page).to have_content("2x (4.00 Kč)")

    expect{click_on "I'm done"; sleep(1)}.to change{ProductUser.count}.by(2)
    expect(page).to have_content "Order was successfully created"
  end

  it 'remove food from order', :request => true, :js =>true do
    visit '/'
    page.find("h5", text: user.name).click
    page.find("a", text: category.name).click
    page.find("h5", text: product.name).click
    page.find("h5", text: product.name).click
    within ".panel" do
      expect(page).to have_content("2x (4.00 Kč)")
      page.find("div.col-lg-9", text: product.name).click
      expect(page).to have_content("1x (2.00 Kč)")
    end
  end

  it 'display overview', :request => true, :js =>true do
    product_user
    visit '/'
    page.find("h5", text: user.name).click
    page.find("a", text: "Overview").click

    within ".modal-content" do
      Date::MONTHNAMES.compact.each do |month|
        expect(page).to have_content(month)
      end

      expect(page.find("th", text: product.name)).not_to be_nil
      expect(page.find("td", text: "30.00 Kč")).not_to be_nil
    end
  end

  it 'cancel order', :request => true, :js =>true do
    visit '/'
    page.find("h5", text: user.name).click
    click_on "Cancel"
    expect(current_path).to eq "/"
  end



end