module Admin
  class Categories < Admin::Base
    protected_post '/categories' do
      content_type :json
      category = Category.new(params.except(*EXCEPTED_PARAMS))
      category.save
      category.to_json
    end

    protected_get '/categories/:id' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      Category.first(id: params[:id]).to_json
    end

    protected_put '/categories/:id' do
      content_type :json
      category = Category.first(id: params[:id])
      category.update(params.except(*EXCEPTED_PARAMS))
      category.to_json
    end

    protected_delete '/categories/:id' do
      content_type :json
      category = Category.first(id: params[:id])
      if category.destroy
        Product.all(category_id: category.id).update(category_id: nil)
      end
      category.to_json
    end
  end
end