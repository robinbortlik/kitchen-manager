module Public
  class Products < Public::Base

    get '/products' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      Product.all(:order => :position.asc ).to_a.to_json
    end

  end
end