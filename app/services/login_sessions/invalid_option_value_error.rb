# frozen_string_literal: true

module LoginSessions
  # Error thrown when an invalid option value is provided.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class InvalidOptionValueError < RuntimeError; end
end
