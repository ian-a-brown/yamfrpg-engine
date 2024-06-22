# frozen_string_literal: true

require 'action_controller'
require_relative '../adapter'

module LoginSessions
  module Adapters
    # Login sessions adapater for Rails API controllers.
    # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
    class RailsApiAdapter
      extend LoginSessions::Adapter

      class << self
        def base_class
          ::ActionController::API
        end
      end
    end
  end
end
