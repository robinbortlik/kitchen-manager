class Application < Sinatra::Base

  get '/product_users' do
    content_type :json
    ProductUser.all(:conditions => ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]]).to_json
  end

  post '/product_users' do
    content_type :json
    unless ProductUser.store_order(params[:products], params[:user_id])
      status 500
    end
    "".to_json
  end
end