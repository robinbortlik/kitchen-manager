class OrganizationUnit
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :position, Integer
end