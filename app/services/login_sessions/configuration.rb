# frozen_string_literal: true

module LoginSessions
  # rubocop: disable Style/ClassVars
  # COnfiguration for login sessions.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  module Configuration
    mattr_accessor :adapters_dependencies
    mattr_accessor :controller_adapters
    mattr_reader :fallback
    mattr_accessor :header_names
    mattr_accessor :identifiers
    mattr_accessor :model_adapters
    mattr_accessor :sign_in_token
    mattr_accessor :skip_devise_trackable

    # Default configuration.
    @@fallback = :devise
    @@header_names = {}
    @@identifiers = {}
    @@sign_in_token = false
    @@controller_adapters = %w[rails rails_api rails_metal]
    @@model_adapters = %w[active_record mongoid]
    @@adapters_dependencies = {
      'active_record' => 'ActiveRecord::Base',
      'mongoid' => 'Mongoid::Document',
      'rails' => 'ActionController::Base',
      'rails_api' => 'ActionController::API',
      'rails_metal' => 'ActionController::Metal'
    }
    @@skip_devise_trackable = true

    # Allow the default configuratiion to be overridden in initializers.
    def configure
      yield self if block_given?
    end

    def parse_options(options)
      options[:fallback] = choose_fallback(options) unless options[:fallback].presence
      options.reject! { |k, _v| k == :fallback_to_devise }
      options
    end

    private

    def choose_fallback(options)
      return :devise if options[:fallback_to_devise]
      return LoginSessions.fallback if options[:fallback_to_devise] != false
      return :none if LoginSessions.fallback == :devise

      LoginSessions.fallback
    end
  end
  # rubocop: enable Style/ClassVars
end
