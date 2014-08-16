require 'psych'

class AppSetting
  FILE_PATH = File.dirname(__FILE__) + '/../config/settings.yml'

  def self.store
    File.open(FILE_PATH , 'w+') do |file|
      file.write(Psych.dump(config))
    end
    puts "Don't forget to restart application!"
  end

  def self.config
    @config ||= File.open(FILE_PATH , 'a+') do |file|
      Psych.load(file.read) || {}
    end
  end

  def self.currency=(val)
    config[:currency] = val
    store
  end

  def self.admin_name=(val)
    config[:admin_name] = BCrypt::Password.create(val.to_s).to_s
    store
  end

  def self.admin_password=(val)
    config[:admin_password] = BCrypt::Password.create(val.to_s).to_s
    store
  end

  def self.currency
    config[:currency]
  end

  def self.admin_name
    config[:admin_name]
  end

  def self.admin_password
    config[:admin_password]
  end
end