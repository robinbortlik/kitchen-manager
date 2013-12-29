class Application < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  get '/' do
    erb :index
  end

  assets do
    js :app, ['/js/store.js', '/js/app.js', '/js/**/*.js']
    css :app, ['/css/*.css']
  end

end