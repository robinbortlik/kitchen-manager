module Admin
  class Base < Sinatra::Base
    helpers Authorize

    def self.protected_get(url, opts = {}, &block)
      get(url, opts){authorize!; instance_eval(&block);}
    end

    def self.protected_post(url, opts = {}, &block)
      post(url, opts){authorize!; instance_eval(&block);}
    end

    def self.protected_put(url, opts = {}, &block)
      put(url, opts){authorize!; instance_eval(&block);}
    end

    def self.protected_delete(url, opts = {}, &block)
      delete(url, opts){authorize!; instance_eval(&block);}
    end

  end
end