class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :image, Text
  property :deleted, Boolean
end