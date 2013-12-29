require 'rubygems'
require 'bundler'
require 'json'

Bundler.require


require './config/environment'
require './application'

run Application
use Rack::PostBodyContentTypeParser