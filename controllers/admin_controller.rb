# Define Startups actions
class Application < Sinatra::Base

  get '/admin' do
    redirect '/#/admin'
  end

end