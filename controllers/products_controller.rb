# Define Startups actions
class Application < Sinatra::Base

  get '/products' do
    content_type :json
    Product.all.to_json
  end

  post '/products' do
    content_type :json
    product = Product.new(name: params[:name], image: params[:image], price: params[:price])
    product.save
    product.to_json
  end

  get '/products/:id' do
    content_type :json
    Product.first(id: params[:id]).to_json
  end

  put '/products/:id' do
    content_type :json
    product = Product.first(id: params[:id])
    product.update(name: params[:name], image: params[:image], price: params[:price])
    product.to_json
  end

  delete '/products/:id' do
    content_type :json
    product = Product.first(id: params[:id])
    product.update(deleted: true)
    product.to_json
  end
end