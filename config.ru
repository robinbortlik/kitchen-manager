require 'rubygems'
require 'bundler'
require 'json'

Bundler.require


require './config/environment'
require './application'

run Application

use Rack::Deflater
use Rack::Parser, :content_types => {
  'application/json'  => Proc.new { |body| ::MultiJson.decode body }
}