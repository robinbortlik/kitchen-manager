require 'sinatra/ember'

class Application < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack
  register Sinatra::Ember
  use AdminController
  use PublicController
  helpers Authorize

  use Rack::Session::Moneta, store: Moneta.new(:DataMapper, setup: ("sqlite://#{Dir.pwd}/db/development.db"))

  get '/' do
    erb :index
  end

  get '/admin' do
    authorize!
    session[:is_admin] = true
    redirect '/#/admin'
  end

  helpers do
    def is_admin
      !!session[:is_admin]
    end
  end

  if production?
    configure do
      enable :logging
      file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file
      set :logging, Logger::INFO
    end
  end

  assets do
    serve '/public_app', from: 'app'
    serve '/admin_app', from: 'app'
    serve '/vendor/js', from: 'vendor/js'
    serve '/vendor/css', from: 'vendor/css'

    js :public_app, ['/js/store.js', '/js/app.js', '/js/*.js', '/js/helpers/**/*.js', '/js/models/**/*.js', '/js/public/**/*.js']
    js :admin_app, ['/js/admin/**/*.js']

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
    templates '/js/templates_public.js', ['app/js/public/templates/**/*.hbs'], :relative_to => 'app/js/public/templates'
    templates '/js/templates_admin.js', ['app/js/admin/templates/**/*.hbs'], :relative_to => 'app/js/admin/templates'
  }

end