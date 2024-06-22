# frozen_string_literal: true

module LoginSessions
  # Module to provide token/UUID authentication handling via login sessions.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  module ActsAsTokenUuidAuthenticationHandler
    def acts_as_token_uuid_authentication_handler_for(model, options = {})
      include LoginSessions::TokenUuidAuthenticationHandler

      handle_token_uuid_authentication_for(model, options)
    end
  end
end
