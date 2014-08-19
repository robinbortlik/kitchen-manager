module Public
  class ProductUsers < Public::Base

    get '/product_users/user_overview' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      OjSerializer.serialize ProductUser.all(conditions: ["user_id = ? AND strftime('%Y', created_at) = ?", params[:user_id], params[:year]]).to_a
    end

    get '/product_users/:id/last_order' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      last = ProductUser.all(conditions: ["user_id = ?", params[:id]]).last
      return [].to_json unless last
      OjSerializer.serialize ProductUser.all(conditions: ["user_id = ? AND created_at = ?", params[:id], last.created_at]).map(&:product_id)
    end

    post '/product_users' do
      content_type :json
      unless ProductUser.store_order(params[:products], params[:user_id])
        status 500
      end
      "".to_json
    end

    delete '/product_users/:id' do
      content_type :json
      product_user = ProductUser.first(id: params[:id], is_paid: [nil, false])
      product_user.destroy
      product_user.to_json
    end

    get '/product_users/:id/popular' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      OjSerializer.serialize ProductUser.popular(params[:id]).map(&:product_id)
    end

  end
end