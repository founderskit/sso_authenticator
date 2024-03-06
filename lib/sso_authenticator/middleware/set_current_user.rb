# lib/sso_authenticator/middleware/set_current_user.rb

require 'json'
require 'rack'
require 'active_support'

module SsoAuthenticator
  class SetCurrentUser
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)

      encrypted_session_id = request.cookies['sso_token']

      if encrypted_session_id
        sso_token = SsoAuthenticator::SignedCookie.decrypt(encrypted_session_id)

        set_current_attributes(sso_token) if sso_token
      end

      @app.call(env)
    end

    private

    def set_current_attributes(sso_token)
      session_data = fetch_session_data(sso_token)
      return unless session_data # Exit if session_data is nil or empty

      SsoAuthenticator::Current.payload = session_data
      SsoAuthenticator::Current.user = OpenStruct.new(session_data[:user])
      SsoAuthenticator::Current.workspace = OpenStruct.new(session_data[:workspace])
    end

    def fetch_session_data(sso_token)
      raw_session_data = $session_store.get(sso_token)

      return unless raw_session_data # Exit if there's no session data

      JSON.parse(raw_session_data, symbolize_names: true)
    rescue JSON::ParserError => e
      # Log the error or notify an error tracking service
      nil
    end
  end
end
