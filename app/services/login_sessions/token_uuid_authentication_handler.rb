# frozen_string_literal: true

require 'active_support/concern'
require 'devise'

require_relative 'entities_manager'
require_relative 'devise_fallback_handler'
require_relative 'exception_fallback_handler'
require_relative 'sign_in_handler'

module LoginSessions
  # rubocop: disable Style/ClassVars
  # Handles token UUID authentication.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  module TokenUuidAuthenticationHandler
    extend ActiveSupport::Concern

    included do
      private_class_method :define_token_uuid_authentication_helpers_for
      private_class_method :entities_manager
      private_class_method :fallback_handler
      private_class_method :set_token_uuid_authentication_hooks

      private :authenticate_entity_from_token_uuid!
      private :check_token_has_expired
      private :fallback!
      private :find_record_from_identifier
      private :integrate_with_devise_case_insensitive_keys
      private :perform_sign_in!
      private :sign_in_handler
      private :token_uuid_correct?
    end

    def after_successful_token_uuid_authentication; end

    def authenticate_entity_from_token_uuid!(entity)
      record = find_record_from_identifier(entity)
      return unless token_uuid_correct?(record, entity)

      perform_sign_in!(record, sign_in_handler)
      after_successful_token_uuid_authentication
    end

    def check_token_has_expired(login_session)
      return unless login_session.nil? || login_session.expired?

      login_session&.destroy!
      raise LoginSessions::ExpiredTokenError,
            'No login session found or login session authentication token has expired!'
    end

    def fallback!(entity, fallback_handler)
      fallback_handler.fallback!(self, entity)
    end

    def find_record_from_identifier(entity)
      identifier_param_value = entity.get_identifier_from_params_or_headers(self).presence
      identifier_param_value = integrate_with_devise_case_insensitive_keys(identifier_param_value, entity)

      identifier_param_value && entity.model.find_for_authentication(entity.identifier => identifier_param_value)
    end

    def integrate_with_devise_case_insensitive_keys(identifier_value, entity)
      if identifier_value.present? && Devise.case_insensitive_keys.include?(entity.identifier)
        identifier_value.downcase!
      end
      identifier_value
    end

    def perform_sign_in!(record, sign_in_handler)
      sign_in_handler.sign_in(self, record, store: LoginSessions.sign_in_token)
    end

    def sign_in_handler
      SignInHandler.instance
    end

    def token_uuid_correct?(record, entity)
      token = entity.get_token_from_params_or_headers(self)
      uuid = entity.get_uuid_from_params_or_headers(self)
      login_session = Yamfrpg::Engine::LoginSession.find_by(
        user: record,
        token:,
        uuid:
      )
      check_token_has_expired(login_session)
      true
    end

    # Class methods for token UUID authentication handler.
    module ClassMethods
      def handle_token_uuid_authentication_for(model, options = {})
        model_alias = options[:as] || options['as']
        entity = entities_manager.find_or_create_entity(model, model_alias)
        options = LoginSessions.parse_options(options)
        define_token_uuid_authentication_helpers_for(entity, fallback_handler(options))
        set_token_uuid_authentication_hooks(entity, options)
      end

      def entities_manager
        return class_variable_get(:@@entities_manager) if class_variable_defined?(:@@entities_manager)

        class_variable_set(:@@entities_manager, EntitiesManager.new)
      end

      def fallback_handler(options)
        if class_variable_defined?(:@@fallback_authentication_handler)
          return class_variable_get(:@@fallback_authentication_handler)
        end

        if options[:fallback] == :exception
          return class_variable_set(:@@fallback_authentication_handler, ExceptionFallbackHandler.instance)
        end

        class_variable_set(:@@fallback_authentication_handler, DeviseFallbackHandler.instance)
      end

      # rubocop: disable Metrics/MethodLength
      def define_token_uuid_authentication_helpers_for(entity, fallback_handler)
        method_name = "authenticate_#{entity.name_underscore}_from_token_uuid"
        method_name_bang = "#{method_name}!"

        class_eval do
          define_method method_name.to_sym do
            lambda do |my_entity|
              authenticate_entity_from_token_uuid!(my_entity)
            end.call(entity)
          end

          define_method method_name_bang.to_sym do
            lambda do |my_entity|
              authenticate_entity_from_token_uuid!(my_entity)
              fallback!(my_entity, fallback_handler)
            end.call(entity)
          end
        end
      end
      # rubocop: enable Metrics/MethodLength

      def set_token_uuid_authentication_hooks(entity, options)
        authentication_method = if options[:fallback] == :none
                                  :"authenticate_#{entity.name_underscore}_from_token_uuid"
                                else
                                  :"authenticate_#{entity.name_underscore}_from_token_uuid!"
                                end

        if respond_to?(:before_action)
          before_action authentication_method, options.slice(:only, :except, :if, :unless)
          return
        end

        before_filter authentication_method, options.slice(:only, :except, :if, :unless)
      end
    end
  end
  # rubocop: enable Style/ClassVars
end
