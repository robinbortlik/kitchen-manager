class OrganizationUnit
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :position, Integer

  def self.all_serialized
    organization_units = repository(:default).adapter.select("SELECT id, name, position FROM organization_units ORDER BY position ASC")
    OjSerializer.serialize organization_units.map(&:to_h)
  end
end