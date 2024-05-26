# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Game model for YAMFRPG.
    class Game < ApplicationRecord
      has_many :game_masters, dependent: :destroy, autosave: true
      has_many :players, dependent: :destroy, autosave: true

      validates :game_name, presence: true, uniqueness: true
    end
  end
end
