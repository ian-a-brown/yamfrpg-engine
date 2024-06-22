# frozen_string_literal: true

require 'active_support/version'
require_relative 'login_sessions/acts_as_token_uuid_authenticatable'
require_relative 'login_sessions/acts_as_token_uuid_authentication_handler'
require_relative 'login_sessions/configuration'
require_relative 'login_sessions/expired_token_error'
require_relative 'login_sessions/invalid_option_value_error'
require_relative 'login_sessions/no_adapter_available_error'

# YAMFRPG API login sessions handling.
# This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
module LoginSessions
  extend Configuration

  class << self
    def adapter_dependency_fulfilled?(short_name)
      dependency = LoginSessions.adapters_dependencies[short_name]

      if !respond_to?(:qualified_const_defined?) ||
         (ActiveSupport.respond_to?(:version) && ActiveSupport.version.to_s =~ /^5\.0/)
        return const_defined?(dependency)
      end

      qualified_const_defined?(dependency)
    end

    def ensure_controllers_can_act_as_token_uuid_authentication_handlers(controller_adapters)
      controller_adapters.each do |controller_adapter|
        controller_adapter.base_class.send(:extend, LoginSessions::ActsAsTokenUuidAuthenticationHandler)
      end
    end

    def ensure_models_can_act_as_token_uuid_authenticatables(model_adapters)
      model_adapters.each do |model_adapter|
        model_adapter.base_class.send(:include, LoginSessions::ActsAsTokenUuidAuthenticatable)
      end
    end

    def load_available_adapters(adapters_short_names)
      available_adapters = adapters_short_names.collect do |short_name|
        adapter_name = "login_sessions/adapters/#{short_name}_adapter"
        adapter_name.camelize.constantize if adapter_dependency_fulfilled?(short_name)
      end
      available_adapters.compact!
      raise NoAdapterAvailableError if available_adapters.empty?

      available_adapters
    end
  end

  available_model_adapters = load_available_adapters(LoginSessions.model_adapters)
  ensure_models_can_act_as_token_uuid_authenticatables(available_model_adapters)

  available_controller_adapeters = load_available_adapters(LoginSessions.controller_adapters)
  ensure_controllers_can_act_as_token_uuid_authentication_handlers(available_controller_adapeters)
end
