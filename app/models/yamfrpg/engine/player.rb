# frozen_string_literal: true

module Yamfrpg
  module Engine
    # A player of a game of YAMFRPG.
    class Player < ApplicationRecord
      belongs_to :user, class_name: Yamfrpg::Engine::User.to_s
      belongs_to :game, class_name: Yamfrpg::Engine::Game.to_s
    end
  end
end
