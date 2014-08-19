module Public
  class OrganizationUnits < Public::Base

    get '/organization_units' do
      response.headers['Cache-Control'] = 'no-cache'
      content_type :json
      OrganizationUnit.all_serialized
    end

  end
end