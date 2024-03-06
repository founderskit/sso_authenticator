require 'net/http'
require 'net/https'

module SsoAuthenticator
  class AuthorizationCode
    def self.exchange!(code)
      puts "Debug: Session Store URI is #{SsoAuthenticator.configuration.inspect}"

      uri = URI(SsoAuthenticator.configuration.sso_service_url + "/sso")
      response = Net::HTTP.post_form(uri, code: code, client_id: SsoAuthenticator.configuration.client_id, client_secret: SsoAuthenticator.configuration.client_secret)
      response_body = JSON.parse(response.body).symbolize_keys
      token = response_body[:token]
      raise ActiveRecord::RecordNotFound if token.nil?

      payload = JSON.parse($session_store.get(token)).symbolize_keys
      if payload.nil?
        render json: { error: "Invalid token" }, status: :unauthorized
        return
      end

      token
    end
  end
end
