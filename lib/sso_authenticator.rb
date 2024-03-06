# frozen_string_literal: true

require_relative "sso_authenticator/version"
require "sso_authenticator/signed_cookie"
require "sso_authenticator/current"
require 'sso_authenticator/controller_helpers'
require "sso_authenticator/middleware/sso_middleware"
require 'sso_authenticator/middleware/set_current_user'
require "sso_authenticator/configuration"
require "sso_authenticator/authorization_code"
require "sso_authenticator/railtie" if defined?(Rails)
require "sso_authenticator/controllers/callbacks_controller"

module SsoAuthenticator
end
