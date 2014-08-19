class Product
  include DataMapper::Resource
  property :id,    Serial
  property :name,  String
  property :price, Float
  property :image, Text
  property :deleted, Boolean
  property :category_id, Integer
  property :position, Integer

  def save_image
    return true unless image
    png = Base64.decode64(image['data:image/png;base64,'.length .. -1])
    File.open(image_path, 'wb') do|f|
      f.write(png)
    end
  end

  def image_url
    self.class.image_url(id)
  end

  def self.image_url(id)
    if File.exists? self.image_path(id)
      "/images/products/#{id}.png"
    else
      "/images/noimage.jpg"
    end
  end

  def self.image_path(id)
    "public/images/products/#{id}.png"
  end

  def image_path
    self.class.image_path(id)
  end

  def self.all_serialized
    products = repository(:default).adapter.select("SELECT id, name, price, deleted, category_id, position FROM products")
    array = products.map do |product|
      hash = product.to_h
      hash[:image] = nil
      hash[:image_url] = Product.image_url(hash[:id])
      hash
    end
    OjSerializer.serialize array.to_a
  end

  def to_json(opts={})
    self.image = nil
    super({methods: [:image_url]})
  end
end