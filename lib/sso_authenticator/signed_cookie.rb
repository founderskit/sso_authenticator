module SsoAuthenticator
  class SignedCookie
    def self.encryptor
      secret_key_base = Rails.application.secret_key_base
      cookie_salt = SsoAuthenticator.configuration.cookie_salt

      key = ActiveSupport::KeyGenerator.new(secret_key_base).generate_key(cookie_salt, ActiveSupport::MessageEncryptor.key_len)
      ActiveSupport::MessageEncryptor.new(key)
    end

    def self.encrypt(value)
      encryptor.encrypt_and_sign(value)
    rescue => e
      Rails.logger.error("SignedCookie encryption error: #{e.message}") if defined?(Rails)
      nil
    end

    def self.decrypt(value)
      encryptor.decrypt_and_verify(value)
    rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveSupport::MessageEncryptor::InvalidMessage => e
      Rails.logger.warn("SignedCookie decryption error: #{e.message}") if defined?(Rails)
      nil
    end
  end
end