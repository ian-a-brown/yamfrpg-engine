# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Game master model for YAMFRPG.
    class GameMaster < ApplicationRecord
      belongs_to :game
      belongs_to :user_role

      validates_uniqueness_of :owner, scope: :game_id
    end
  end
end
