# frozen_string_literal: true

require 'action_controller'
require_relative '../adapter'

module LoginSessions
  module Adapters
    # Login sessions adapater for Rails controllers.
    # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
    class RailsAdapter
      extend LoginSessions::Adapter

      class << self
        def base_class
          ::ActionController::Base
        end
      end
    end
  end
end
