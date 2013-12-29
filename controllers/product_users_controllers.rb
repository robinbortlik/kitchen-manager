class Application < Sinatra::Base

  get '/product_users' do
    content_type :json
    ProductUser.all.to_json
  end

  post '/product_users' do
    content_type :json
    created_at = Time.now
    product_users = []
    Array(params[:products]).each do |k, v|
      product_user = ProductUser.new(product_id: v[:id], name: v[:name], price: v[:price], user_id: params[:user_id], created_at: created_at)
      product_users.push product_user
      product_user.save
    end
    product_users.to_json
  end

end