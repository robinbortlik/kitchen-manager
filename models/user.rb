class User
  include DataMapper::Resource
  property :id,    Serial
  property :first_name,  String
  property :last_name,  String
  property :image, Text
  property :deleted, Boolean
  property :organization_unit_id, Integer

  def name
    "#{last_name} #{first_name}"
  end
end