class ProductGroup
  include DataMapper::Resource
  property :id,    Serial
  property :user_id,  Integer
  property :name, String
  property :position, Integer

  has n, :product_groups_products
end