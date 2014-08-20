require 'data_mapper'
require 'base64'
require 'rack/session/moneta'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../controllers/*.rb'].each {|file| require file }

DataMapper.finalize
DataMapper.auto_upgrade!
Spreadsheet.client_encoding = 'UTF-8'

AppSetting.currency ||= '$'
AppSetting.admin_name ||= 'admin'
AppSetting.admin_password ||= 'admin'

Oj.default_options = {mode: :compat }

EXCEPTED_PARAMS = ["splat", "captures", "id", "image_url"]