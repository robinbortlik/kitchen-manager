# Define Startups actions
class Application < Sinatra::Base

  get '/users' do
    content_type :json
    User.all.to_json
  end

  post '/users' do
    content_type :json
    user = User.new(name: params[:name], image: params[:image])
    user.save
    user.to_json
  end

  get '/users/:id' do
    content_type :json
    User.first(id: params[:id]).to_json
  end

  put '/users/:id' do
    content_type :json
    user = User.first(id: params[:id])
    user.update(name: params[:name], image: params[:image])
    user.to_json
  end

  delete '/users/:id' do
    content_type :json
    user = User.first(id: params[:id])
    user.update(deleted: true)
    user.to_json
  end

end