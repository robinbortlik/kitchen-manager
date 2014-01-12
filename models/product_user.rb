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

end