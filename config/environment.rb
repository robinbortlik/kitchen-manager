require 'data_mapper'
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")

Dir[File.dirname(__FILE__) + '/../uploaders/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../controllers/*.rb'].each {|file| require file }

DataMapper.auto_upgrade!