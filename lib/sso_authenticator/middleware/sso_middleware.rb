
module SsoAuthenticator
  class SsoMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      # Middleware logic here
      @app.call(env)
    end
  end
end
