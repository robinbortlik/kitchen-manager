require 'spec_helper'

describe "overview", :request => true, :js =>true do

  let(:user) {FactoryGirl.create(:user, organization_unit_id: organization_unit.id)}
  let(:product) {FactoryGirl.create(:product, price: 2, category_id: category.id)}
  let(:category) {FactoryGirl.create(:category)}
  let(:organization_unit) {FactoryGirl.create(:organization_unit)}
  let!(:product_user) {ProductUser.create(user_id: user.id, product_id: product.id, price: 15, is_paid: false, created_at: Date.today)}

  it 'toggle is paid' do
    visit_admin

    within "table" do
      expect(page.find("th", text: product.name)).not_to be_nil
      expect(page.find("td.sum", text: "15.00 $")).not_to be_nil
      page.find("i.glyphicon-check").click
    end

    expect(page).to have_content "Paid status was set to true"

    within "table" do
      page.find("i.glyphicon-check").click
    end
    expect(page).to have_content "Paid status was set to false"
  end

  it 'filter data' do
    visit_admin
    within "table" do
      expect(page.find("th", text: product.name)).not_to be_nil
      expect(page.find("td.sum", text: "15.00 $")).not_to be_nil
    end

    set_date_input('#dateFrom', '2014-01-01')
    set_date_input('#dateTo', '2014-01-02')

    wait_for_ajax

    within "table" do
      expect(page.find("td.sum", text: "0.00 $")).not_to be_nil
    end

    set_date_input('#dateFrom', product_user.created_at.strftime("%Y-%m-%d"))
    set_date_input('#dateTo', product_user.created_at.strftime("%Y-%m-%d"))

    wait_for_ajax

    within "table" do
      expect(page.find("td.sum", text: "15.00 $")).not_to be_nil
    end

  end

end