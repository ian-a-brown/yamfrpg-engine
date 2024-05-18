# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Game model for YAMFRPG.
    class Game < ApplicationRecord
      belongs_to :owner, class_name: Yamfrpg::Engine::User.to_s

      validates :game_name, presence: true, uniqueness: true
    end
  end
end
