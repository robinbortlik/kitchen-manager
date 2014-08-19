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
    self.class.image_url(id)
  end

  def self.image_url(id)
    if File.exists? self.image_path(id)
      "/images/users/#{id}.png"
    else
      "/images/noimage.jpg"
    end
  end

  def self.image_path(id)
    "public/images/users/#{id}.png"
  end

  def image_path
    self.class.image_path(id)
  end

  def self.all_serialized
    users = repository(:default).adapter.select("SELECT id, first_name, last_name, deleted, organization_unit_id FROM users")
    array = users.sort_alphabetical_by(&:last_name).map do |user|
      hash = user.to_h
      hash[:image] = nil
      hash[:image_url] = User.image_url(hash[:id])
      hash
    end
    OjSerializer.serialize array.to_a
  end

  def to_json(opts={})
    self.image = nil
    super({methods: [:image_url]})
  end
end