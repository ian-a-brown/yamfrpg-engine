# frozen_string_literal: true

module LoginSessions
  # Error thrown when a login session token has expired.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class ExpiredTokenError < RuntimeError; end
end
