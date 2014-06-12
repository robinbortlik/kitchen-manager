class Application < Sinatra::Base

  get '/product_users' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    ProductUser.all(conditions: ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]]).to_json(exclude: :name)
  end

  get '/product_users/user_overview' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    ProductUser.all(conditions: ["user_id = ? AND strftime('%Y', created_at) = ?", params[:user_id], params[:year]]).to_json
  end

  get '/product_users/:id/last_order' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    last = ProductUser.all(conditions: ["user_id = ?", params[:id]]).last
    return [].to_json unless last
    ProductUser.all(conditions: ["user_id = ? AND created_at = ?", params[:id], last.created_at]).map(&:product_id).to_json
  end

  put '/product_users/update_is_paid' do
    content_type :json
    unless ProductUser.all(id: params[:ids]).update(is_paid: params[:is_paid])
      status 500
    end
    "".to_json
  end

  post '/product_users' do
    content_type :json
    unless ProductUser.store_order(params[:products], params[:user_id])
      status 500
    end
    "".to_json
  end

  get '/product_users.xls' do
    content_type 'application/octet-stream'
    product_users = ProductUser.all(conditions: ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]])
    exporter = ProductUserExporter.new(product_users)
    exporter.generate
  end

  get '/product_users/:id/popular' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    ProductUser.popular(params[:id]).map(&:product_id).to_json
  end

end