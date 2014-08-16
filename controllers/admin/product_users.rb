module Admin
  class ProductUsers < Admin::Base
    protected_get '/product_users' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      ProductUser.all(conditions: ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]]).to_json(exclude: :name)
    end

    protected_put '/product_users/update_is_paid' do
      content_type :json
      unless ProductUser.all(id: params[:ids]).update(is_paid: params[:is_paid])
        status 500
      end
      "".to_json
    end

    protected_get '/product_users.xls' do
      content_type 'application/octet-stream'
      product_users = ProductUser.all(conditions: ["DATE(created_at) >= ? AND DATE(created_at) <= ?", params[:from], params[:to]])
      exporter = ProductUserExporter.new(product_users)
      exporter.generate
    end
  end
end