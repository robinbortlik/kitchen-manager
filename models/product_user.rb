class ProductUser
  include DataMapper::Resource
  property :id,    Serial
  property :user_id,  Integer
  property :product_id, Integer
  property :price, Float
  property :name, String
  property :created_at, DateTime
  property :is_paid, Boolean

  def self.store_order(products_params, user_id)
    created_at = Time.now
    ProductUser.transaction do |t|
      begin
        Array(products_params).each do |k, v|
          product_user = ProductUser.new(product_id: v[:id], name: v[:name], price: v[:price], user_id: user_id, created_at: created_at)
          product_user.save!
        end
        true
      rescue DataObjects::Error
        t.rollback
        false
      end
    end
  end

  def self.popular(user_id)
    repository(:default).adapter.select("
      SELECT product_id, COUNT(*) as count
      FROM product_users
      LEFT JOIN products ON products.id = product_users.product_id
      WHERE user_id = ? AND (products.deleted IS NOT 't')
      GROUP BY product_id
      ORDER BY count DESC
      LIMIT 12", user_id)
  end

  def self.all_serialized(options = {})
    query = repository(:default).new_query(ProductUser, options)
    sql = repository(:default).adapter.send(:select_statement, query)
    array = repository(:default).adapter.select sql[0]
    OjSerializer.serialize array.map(&:to_h)
  end
end