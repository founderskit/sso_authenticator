module SsoAuthenticator
  module ControllerHelpers
    def logged_in?
      SsoAuthenticator::Current.user.present?
    end

    def require_login
      return if logged_in?

      sso_service_url = SsoAuthenticator.configuration.sso_service_url
      client_id = SsoAuthenticator.configuration.client_id
      redirect_to "#{sso_service_url}/sso/#{client_id}"
    end
  end
end
