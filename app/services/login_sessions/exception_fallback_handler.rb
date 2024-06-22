# frozen_string_literal: true

module LoginSessions
  # Fallback handler for exceptions during login sessions.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class ExceptionFallbackHandler
    include Singleton

    def fallback!(controller, entity)
      throw(:warden, scope: entity.name_underscore.to_sym) if controller.send("current_#{entity.name_underscore}").nil?
    end
  end
end
