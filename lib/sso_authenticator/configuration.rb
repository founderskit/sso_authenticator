module SsoAuthenticator
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    configuration.validate_variables
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

    def validate_variables
      %i[client_id client_secret session_store_uri sso_service_url cookie_salt].each do |variable|
        raise "Error: #{variable} is not set" if send(variable).empty?
      end
    end
  end
end
