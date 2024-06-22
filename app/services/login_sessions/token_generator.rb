# frozen_string_literal: true

module LoginSessions
  # Generates a token for login sessions.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class TokenGenerator
    include Singleton

    def generate_token
      Devise.friendly_token
    end
  end
end
