class Product
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :price, Float
  property :image, Text
  property :deleted, Boolean
  property :category_id, Integer
  property :position, Integer
end