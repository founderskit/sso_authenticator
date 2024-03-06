require 'rails'

module SsoAuthenticator
  class Railtie < Rails::Railtie
    initializer 'sso_authenticator.add_middleware' do |app|
      app.middleware.use MiddlewareClassName
    end

    initializer 'sso_authenticator.add_routes' do
      Rails.application.routes.append do
        get '/auth/sso/callback', to: 'sso_authenticator#callback'
      end
    end
  end
end
