# frozen_string_literal: true

class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

    def secret_key_base
      Rails.application.secrets.secret_key_base || ENV['SECRET_KEY_BASE']
    end
  end
end
