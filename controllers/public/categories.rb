module Public
  class Categories < Public::Base

    get '/categories' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      Category.all(:order => :position.asc ).to_json
    end

  end
end