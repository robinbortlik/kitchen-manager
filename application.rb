require 'sinatra/ember'

class Application < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack
  register Sinatra::Ember

  configure do
    enable :logging
    file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
    set :logging, Logger::INFO
  end

  get '/' do
    erb :index
  end

  get '/health-check' do
    "OK"
  end

  assets do
    serve '/app', from: 'app'
    serve '/vendor/js', from: 'vendor/js'
    serve '/vendor/css', from: 'vendor/css'

    js :app, ['/js/store.js', '/js/app.js', '/js/**/*.js']
    css :app, ['/css/*.css']
    css :vendor_css, ['/vendor/css/*.css']
    js :vendor_js, ['/vendor/js/jquery-2.1.1-min.js',
      '/vendor/js/handlebars-1.3.0.js',
      '/vendor/js/ember-1.8.0-beta.js',
      '/vendor/js/*.js']
    prebuild true
    expires 86400*365, :public
    cache_dynamic_assets true
  end

  ember {
    templates '/js/templates.js', ['app/js/templates/**/*.hbs'], :relative_to => 'app/js/templates'
  }

end