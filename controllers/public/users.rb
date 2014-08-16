module Public
  class Users < Public::Base

    get '/users' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      User.all.sort_alphabetical_by(&:last_name).to_json
    end

  end
end