class Application < Sinatra::Base

  get '/product_users' do
    content_type :json
    ProductUser.all(:conditions => ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]]).to_json
  end

  get '/product_users/user_overview' do
    content_type :json
    ProductUser.all(:conditions => ["user_id = ? AND strftime('%Y', created_at) = ?", params[:user_id], params[:year]]).to_json
  end

  post '/product_users' do
    content_type :json
    unless ProductUser.store_order(params[:products], params[:user_id])
      status 500
    end
    "".to_json
  end
end