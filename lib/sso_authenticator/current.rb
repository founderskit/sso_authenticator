module SsoAuthenticator
  class Current < ActiveSupport::CurrentAttributes
    attribute :payload
    attribute :user
    attribute :workspace
    attribute :user_agent
    attribute :ip_address
  end
end