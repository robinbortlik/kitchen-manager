module Public
  class Users < Public::Base

    get '/users' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      User.all_serialized
    end

  end
end