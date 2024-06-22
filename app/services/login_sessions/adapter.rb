# frozen_string_literal: true

module LoginSessions
  # Adapter module for API login sessions token UUID authentication.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  module Adapter
    def base_class
      raise NotImplementedError
    end
  end
end
