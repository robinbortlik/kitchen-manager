module Public
  class OrganizationUnits < Public::Base

    get '/organization_units' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      OrganizationUnit.all(:order => :position.asc ).to_json
    end

  end
end