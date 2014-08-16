module Admin
  class Products < Admin::Base
    protected_post '/products' do
      content_type :json
      product = Product.new(params.except(*EXCEPTED_PARAMS))
      product.save
      product.save_image
      product.to_json
    end

    protected_get '/products/:id' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      Product.first(id: params[:id]).to_json
    end

    protected_put '/products/:id' do
      content_type :json
      product = Product.first(id: params[:id])
      product.update(params.except(*EXCEPTED_PARAMS))
      product.save_image
      product.to_json
    end
  end
end

