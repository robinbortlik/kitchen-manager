class ProductGroupsProduct
  include DataMapper::Resource
  property :id,    Serial
  property :product_id,  Integer
  property :product_group_id,  Integer
  belongs_to :product_group
end