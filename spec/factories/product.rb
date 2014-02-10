FactoryGirl.define do
  factory :product do
    name "Banana"
    price 23

    after(:build) do
      cat = Category.first
      category_id = cat ? cat.id : FactoryGirl.create(:category).id
    end
  end
end