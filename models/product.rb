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
    if File.exists? image_path
      "/images/products/#{id}.png"
    else
      "/images/noimage.jpg"
    end
  end

  def image_path
    "public/images/products/#{id}.png"
  end

  def to_json(opts={})
    self.image = nil
    super({methods: [:image_url]})
  end
end