require 'sinatra/ember'

class Application < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack
  register Sinatra::Ember

  get '/' do
    erb :index
  end

  get '/health-check' do
    "OK"
  end

  assets do
    js :app, ['/js/store.js', '/js/app.js', '/js/**/*.js']
    css :app, ['/css/*.css']
  end

  ember {
    templates '/js/templates.js', ['app/js/templates/**/*.hbs'], :relative_to => 'app/js/templates'
  }

end