class Category
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :position, Integer

  def self.all_serialized
    categories = repository(:default).adapter.select("SELECT id, name, position FROM categories ORDER BY position ASC")
    OjSerializer.serialize categories.map(&:to_h)
  end
end