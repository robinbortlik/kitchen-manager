Dir[File.dirname(__FILE__) + '/public/*.rb'].sort.each {|file| require file }

class PublicController < Sinatra::Base
  use Public::Categories
  use Public::OrganizationUnits
  use Public::ProductUsers
  use Public::ProductGroups
  use Public::Products
  use Public::Users

  get '/health-check' do
    "OK"
  end
end