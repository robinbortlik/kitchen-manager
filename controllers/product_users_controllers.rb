class Application < Sinatra::Base

  get '/product_users' do
    content_type :json
    ProductUser.all(conditions: ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]]).to_json
  end

  get '/product_users/user_overview' do
    content_type :json
    ProductUser.all(conditions: ["user_id = ? AND strftime('%Y', created_at) = ?", params[:user_id], params[:year]]).to_json
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

  get '/product_users.csv' do
    content_type 'application/octet-stream'
    product_users = ProductUser.all()
    products = Product.all
    users = User.all
    csv_string = CSV.generate do |csv|
      csv << [""] + products.map(&:name) + ["Sum"]
      users.each do |u|
        pus = product_users.select{|pu| pu.user_id == u.id}
        tmp = products.map {|p| pus.select{|pu| pu.product_id == p.id }.map(&:price).reduce(:+) }
        csv << [u.name] + tmp + [tmp.compact.reduce(:+)]
      end
      csv
    end
    csv_string
  end
end