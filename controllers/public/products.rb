module Public
  class Products < Public::Base

    get '/products' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      Product.all_serialized
    end

  end
end