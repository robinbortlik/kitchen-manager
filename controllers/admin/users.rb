module Admin
  class Users < Admin::Base
    protected_post '/users' do
      content_type :json
      user = User.new(params.except(*EXCEPTED_PARAMS))
      user.save
      user.save_image
      user.to_json
    end

    protected_get '/users/:id' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      User.first(id: params[:id]).to_json
    end

    protected_put '/users/:id' do
      content_type :json
      user = User.first(id: params[:id])
      user.update(params.except(*EXCEPTED_PARAMS))
      user.save_image
      user.to_json
    end
  end
end