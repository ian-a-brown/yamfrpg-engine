# frozen_string_literal: true

module LoginSessions
  # Fallback handler for YAMFRPG logins to use Devise.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class DeviseFallbackHandler
    include Singleton

    def fallback!(controller, entity)
      authenticate_entity!(controller, entity)
    end

    def authenticate_entity!(controller, entity)
      method = "authenticate_#{entity.name_underscore}".to_sym
      controller.send(method) if controller.respond_to?(method)
    end
  end
end
