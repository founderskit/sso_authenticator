module SsoAuthenticator
  module ControllerHelpers
    def logged_in?
      # Assuming SsoAuthenticator::Current.user is set in your middleware
      # and it returns nil if no user is logged in
      SsoAuthenticator::Current.user.present?
    end

    def require_login
      unless logged_in?
        sso_service_url = SsoAuthenticator.configuration.sso_service_url
        client_id = SsoAuthenticator.configuration.client_id
        redirect_to "#{sso_service_url}?client_id=#{client_id}"
      end
    end
  end
end