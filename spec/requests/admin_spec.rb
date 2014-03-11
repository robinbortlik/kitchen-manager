require 'spec_helper'

describe "Admin" do

  let(:user) {FactoryGirl.create(:user, organization_unit_id: organization_unit.id)}
  let(:product) {FactoryGirl.create(:product, price: 2, category_id: category.id)}
  let(:category) {Category.first || FactoryGirl.create(:category)}
  let(:organization_unit) {FactoryGirl.create(:organization_unit)}
  let(:product_user) {ProductUser.create(user_id: user.id, product_id: product.id, price: 15, is_paid: false, created_at: Date.today)}

  before do
    page.evaluate_script("window.password = 'f00d' ")
  end

  describe "overview" do

    it 'toggle is paid', :request => true, :js =>true do
      product_user
      visit '/admin'
      within "table" do
        expect(page.find("th", text: product.name)).not_to be_nil
        expect(page.find("strong", text: "15.00 Kč")).not_to be_nil
        page.find("i.glyphicon-check").click
      end
      expect(page).to have_content "Paid status was set to true"

      within "table" do
        page.find("i.glyphicon-check").click
      end
      expect(page).to have_content "Paid status was set to false"
    end

    it 'filter data', :request => true, :js =>true do
      product_user
      visit '/admin'
      within "table" do
        expect(page.find("th", text: product.name)).not_to be_nil
        expect(page.find("strong", text: "15.00 Kč")).not_to be_nil
      end

      fill_in 'From', with: '2014-01-01'
      fill_in 'To', with: '2014-01-02'

      within "table" do
        expect(page.find("strong", text: "0.00 Kč")).not_to be_nil
      end

      fill_in 'From', with: Date.today.to_s
      fill_in 'To', with: Date.today.to_s

      within "table" do
        expect(page.find("strong", text: "15.00 Kč")).not_to be_nil
      end

    end

  end


  describe "users" do

    it "create user", :request => true, :js =>true do
      visit '/admin'
      click_on "Users"
      page.find("button", text: "New").click
      expect(page).to have_selector(".modal-content")
      page.find(:css, "input[placeholder='First Name']").set "Robin"
      page.find(:css, "input[placeholder='Last Name']").set "Bortlik"
      page.find(:css, "select").set organization_unit.id
      expect{click_on "Save"; sleep(2)}.to change{User.count}.by(1)
      within "table" do
        expect(page).to have_content "Robin"
      end
    end

    it "edit user", :request => true, :js =>true do
      user
      visit '/admin'
      click_on "Users"
      expect(page).to have_content "Alex Zavadsky"
      page.find(:css, "span.glyphicon-pencil").click
      expect(page).to have_selector(".modal-content")
      page.find(:css, "input[placeholder='First Name']").set "new Robin"
      page.find(:css, "input[placeholder='Last Name']").set "Bortlik"
      expect{click_on "Save"; sleep(1)}.to change{User.last.name}.from("Alex Zavadsky").to("new Robin Bortlik")
      within "table" do
        expect(page).to have_content "new Robin"
      end
    end

    it "mark as deleted", :request => true, :js =>true do
      user
      visit '/admin'
      click_on "Users"
      expect{page.find(:css, "span.glyphicon-trash").click; sleep(1)}.to change{User.last.deleted}.from(nil).to(true)
    end

    it "unmark as deleted", :request => true, :js =>true do
      user.deleted = true
      user.save!
      visit '/admin'
      click_on "Users"
      expect{page.find(:css, "span.glyphicon-refresh").click; sleep(1)}.to change{User.last.deleted}.from(true).to(false)
    end

  end


  describe "products" do

    it "create product", :request => true, :js =>true do
      visit '/admin'
      click_on "Products"
      page.find("button", text: "New").click
      expect(page).to have_selector(".modal-content")
      page.find(:css, "input[placeholder='Name']").set "Product 1"
      page.find(:css, "input[placeholder='Price']").set "10"
      page.find(:css, "select").set category.id
      expect{click_on "Save"; sleep(1)}.to change{Product.count}.by(1)
      within "table" do
        expect(page).to have_content "Product 1"
        expect(page).to have_content "10"
      end
    end

    it "edit product", :request => true, :js =>true do
      product
      visit '/admin'
      click_on "Products"
      expect(page).to have_content "Banana"
      page.find(:css, "span.glyphicon-pencil").click
      expect(page).to have_selector(".modal-content")
      page.find(:css, "input[placeholder='Name']").set "new Apple"
      page.find(:css, "select").set category.id
      expect{click_on "Save"; sleep(1)}.to change{Product.last.name}.from("Banana").to("new Apple")
      within "table" do
        expect(page).to have_content "new Apple"
      end
    end

    it "mark as deleted", :request => true, :js =>true do
      product
      visit '/admin'
      click_on "Products"
      expect{page.find(:css, "span.glyphicon-trash").click; sleep(1)}.to change{Product.last.deleted}.from(nil).to(true)
    end

    it "unmark as deleted", :request => true, :js =>true do
      product.deleted = true
      product.save!
      visit '/admin'
      click_on "Products"
      expect{page.find(:css, "span.glyphicon-refresh").click; sleep(1)}.to change{Product.last.deleted}.from(true).to(false)
    end

  end


end