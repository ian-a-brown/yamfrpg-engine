# frozen_string_literal: true

module Yamfrpg
  module Engine
    # User role model for YAMFRPG.
    class UserRole < ApplicationRecord
      belongs_to :user

      enum role: %i[administrator game_master player]

      validates_uniqueness_of :role, scope: :user_id
    end
  end
end
