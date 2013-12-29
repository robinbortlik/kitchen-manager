require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'sinatra'
Sinatra::Application.environment = :test

require 'capybara/rspec'
require 'database_cleaner'
require 'rack/test'
require 'rspec'
require 'shoulda'
require 'factory_girl'

require File.join(File.dirname(__FILE__), '..', 'config', 'environment.rb')
require File.join(File.dirname(__FILE__), '..', 'application.rb')
Dir[File.dirname(__FILE__) + '/factories/*.rb'].each {|file| require file }

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  Rack::Builder.parse_file(File.expand_path('../../config.ru', __FILE__)).first 
end

Capybara.app =  app
 
RSpec.configure do |config|
  DatabaseCleaner.strategy = :truncation
  
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
end