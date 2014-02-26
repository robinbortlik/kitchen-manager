class Application < Sinatra::Base

  get '/organization_units' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    OrganizationUnit.all(:order => :position.asc ).to_json
  end

  post '/organization_units' do
    content_type :json
    organization_unit = OrganizationUnit.new(params.except(*EXCEPTED_PARAMS))
    organization_unit.save
    organization_unit.to_json
  end

  get '/organization_units/:id' do
    response.headers['Cache-Control'] = 'no-cache'
    content_type :json
    OrganizationUnit.first(id: params[:id]).to_json
  end

  put '/organization_units/:id' do
    content_type :json
    organization_unit = OrganizationUnit.first(id: params[:id])
    organization_unit.update(params.except(*EXCEPTED_PARAMS))
    organization_unit.to_json
  end

  delete '/organization_units/:id' do
    content_type :json
    OrganizationUnit = organization_unit.first(id: params[:id])
    if organization_unit.destroy
      User.all(organization_unit_id: organization_unit.id).update(organization_unit_id: nil)
    end
    organization_unit.to_json
  end
end