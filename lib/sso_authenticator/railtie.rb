require 'rails'

module SsoAuthenticator
  class Railtie < Rails::Railtie
    initializer 'sso_authenticator.add_middleware' do |app|
      app.middleware.use SsoAuthenticator::SsoMiddleware
      app.middleware.use SsoAuthenticator::SetCurrentUser
    end

    initializer 'sso_authenticator.add_routes' do
      Rails.application.routes.append do
        get '/sso/callback', to: 'sso_authenticator/callbacks#callback'
      end
    end

    initializer 'sso_authenticator.include_controller_helpers' do
      ActiveSupport.on_load(:action_controller_base) do
        include SsoAuthenticator::ControllerHelpers
      end
    end

    initializer 'sso_authenticator.initialize_redis_store' do
      Rails.application.config.after_initialize do
        $session_store = Redis.new(url: SsoAuthenticator.configuration.session_store_uri)
      end
    end
  end
end
