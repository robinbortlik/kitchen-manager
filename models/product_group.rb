class ProductGroup
  include DataMapper::Resource
  property :id,    Serial
  property :user_id,  Integer
  property :name, String
  property :position, Integer

  has n, :product_groups_products

  def self.all_serialized(user_id)
    product_groups = repository(:default).adapter.select("SELECT id, user_id, name, position FROM product_groups WHERE user_id = #{user_id.to_i} ORDER BY position ASC")
    product_groups.map! do |pg|
      hash = pg.to_h
      hash[:product_groups_products] = repository(:default).adapter.select("SELECT id, product_id, product_group_id FROM product_groups_products WHERE product_group_id = #{pg.id.to_i}").map(&:to_h)
      hash
    end
    OjSerializer.serialize product_groups
  end
end