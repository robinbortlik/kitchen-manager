Dir[File.dirname(__FILE__) + '/admin/*.rb'].sort.each {|file| require file }

class AdminController < Sinatra::Base
  use Admin::Categories
  use Admin::OrganizationUnits
  use Admin::ProductUsers
  use Admin::Products
  use Admin::Users
end