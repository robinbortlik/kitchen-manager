# Define Startups actions
class Application < Sinatra::Base

  get '/users' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    User.all.to_json
  end

  post '/users' do
    content_type :json
    user = User.new(params.except(*EXCEPTED_PARAMS))
    user.save
    user.to_json
  end

  get '/users/:id' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    User.first(id: params[:id]).to_json
  end

  put '/users/:id' do
    content_type :json
    user = User.first(id: params[:id])
    user.update(params.except(*EXCEPTED_PARAMS))
    user.to_json
  end

end