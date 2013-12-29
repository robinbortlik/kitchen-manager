class ProductUser
  include DataMapper::Resource
  property :id,    Serial
  property :user_id,  Integer
  property :product_id, Integer
  property :price, Float
  property :name, String
  property :created_at, DateTime
end