# frozen_string_literal: true

module LoginSessions
  # Error thrown when no adapter is available.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class NoAdapterAvailableError < RuntimeError; end
end
