module Authorize
  def authorize!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  private
  def authorized?
    @crypted_name ||= BCrypt::Password.new(AppSetting.admin_name)
    @crypted_password ||= BCrypt::Password.new(AppSetting.admin_password)

    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @crypted_name == @auth.credentials[0] and @crypted_password == @auth.credentials[1]
  end
end