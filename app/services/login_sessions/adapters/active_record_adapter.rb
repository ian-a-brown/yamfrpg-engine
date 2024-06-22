# frozen_string_literal: true

require 'active_record'
require_relative '../adapter'

module LoginSessions
  module Adapters
    # Login sessions adapater for active record objects.
    # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
    class ActiveRecordAdapter
      extend LoginSessions::Adapter

      class << self
        def base_class
          ::ActiveRecord::Base
        end
      end
    end
  end
end
