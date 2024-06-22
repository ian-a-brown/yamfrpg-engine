# frozen_string_literal: true

module LoginSessions
  # Module for models that act as token UUID authenticatable.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  module ActsAsTokenUuidAuthenticatable
    extend ::ActiveSupport::Concern

    included do
      private :generate_authentication_token
      private :token_suitable?
      private :token_generator
    end

    def ensure_authentication_token
      return unless authentication_token.blank?

      self.authentication_token = generate_authentication_token(token_generator)
    end

    def generate_authentication_token(token_generator)
      loop do
        token = token_generator.generate_token
        break token if token_suitable?(token)
      end
    end

    def token_generator
      TokenGenerator.instance
    end

    def token_suitable?(token)
      Yamfrpg::Engine::LoginSession.where(token:).none?
    end

    # Class methods for the concern.
    module ClassMethods
      def acts_as_token_uuid_authenticatable(_options = {})
        before_save :ensure_authentication_token
      end
    end
  end
end
