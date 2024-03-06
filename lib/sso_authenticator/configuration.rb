module SsoAuthenticator
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :session_store_uri, :sso_service_url, :cookie_salt

    def initialize
      @client_id = ''
      @client_secret = ''
      @session_store_uri = ''
      @sso_service_url = ''
      @cookie_salt = ''
    end
  end
end
