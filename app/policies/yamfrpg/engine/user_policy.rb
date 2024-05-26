# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Pundit policy for users in YAMFRPG.
    class UserPolicy < EnginePolicy
      # Pundit scope for users.
      class Scope < EnginePolicy::Scope
        def resolve
          return User.where(id: user.id) unless user.administrator?

          User.all
        end
      end
    end
  end
end
