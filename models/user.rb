class User
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :first_name,  String
  property :last_name,  String
  property :image, Text
  property :deleted, Boolean
  property :organization_unit_id, Integer
end