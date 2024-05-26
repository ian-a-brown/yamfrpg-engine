# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Base policy for the engine.
    class EnginePolicy
      def initialize(user, record)
        raise Pundit::NotAuthorizedError, 'must be logged in' unless user

        @user   = user
        @record = record
      end

      # Base policy scope for the engine.
      class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
          raise Pundit::NotAuthorizedError, 'must be logged in' unless user

          @user = user
          @scope = scope
        end
      end
    end
  end
end
