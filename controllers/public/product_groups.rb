module Public
  class ProductGroups < Public::Base

    get '/product_groups/:id' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      ProductGroup.all(user_id: params[:id], order: :position.asc).to_json(methods: [:product_groups_products])
    end

    post '/product_groups' do
      content_type :json
      product_group = ProductGroup.new(params.except(*EXCEPTED_PARAMS))
      product_group.save
      product_group.to_json
    end

    delete '/product_groups/:id' do
      content_type :json
      product_group = ProductGroup.first(id: params[:id])
      product_group.product_groups_products.destroy
      product_group.destroy
      product_group.to_json
    end
  end
end