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

  def save_image
    return true unless image
    png = Base64.decode64(image['data:image/png;base64,'.length .. -1])
    File.open(image_path, 'wb') do|f|
      f.write(png)
    end
  end

  def image_url
    if File.exists? image_path
      "/images/users/#{id}.png"
    else
      "/images/noimage.jpg"
    end
  end

  def image_path
    "public/images/users/#{id}.png"
  end

  def to_json(opts={})
    self.image = nil
    super({methods: [:image_url]})
  end
end