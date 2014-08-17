require 'spec_helper'

describe 'basic functions', :request => true, :js =>true do

  let!(:user) {FactoryGirl.create(:user)}
  let!(:product) {FactoryGirl.create(:product, price: 2, category_id: category.id)}
  let(:category) {Category.first || FactoryGirl.create(:category)}
  let(:product_user) {ProductUser.create(user_id: user.id, product_id: product.id, price: 30)}


  it 'get home page' do
    visit '/'
    page.should have_selector("#ember-app")
  end

  it 'display users' do
    visit '/'
    page.should have_content(user.name)
  end

  it 'order food' do
    visit '/'
    page.find("h5", text: user.name).click
    page.find("a", text: category.name).click

    expect(page).to have_content("0.00 $")

    page.find("h4", text: product.name).click
    page.find("h4", text: product.name).click

    expect(page).to have_content("4.00 $")

    expect{click_on "Done"; wait_for_ajax}.to change{ProductUser.count}.by(2)
    expect(page).to have_content "Order was successfully created"
  end

  it 'remove food from order' do
    visit '/'
    page.find("h5", text: user.name).click
    page.find("a", text: category.name).click
    page.find("h4", text: product.name).click
    page.find("h4", text: product.name).click
    within ".panel" do
      expect(page).to have_content("4.00 $")
      page.find("div.row", text: '2').click
      expect(page).to have_content("2.00 $")
      page.find("div.row", text: '1')
    end
  end

  it 'display overview' do
    product_user
    visit '/'
    page.find("h5", text: user.name).click
    page.find("a", text: "Overview").click

    Date::MONTHNAMES.compact.each do |month|
      expect(page).to have_content(month)
    end

    expect(page.find("td", text: product.name)).not_to be_nil
    expect(page.find("th", text: "30.00 $")).not_to be_nil
  end

  it 'cancel order' do
    visit '/'
    page.find("h5", text: user.name).click
    click_on "Cancel"
    expect(current_path).to eq "/"
  end



end