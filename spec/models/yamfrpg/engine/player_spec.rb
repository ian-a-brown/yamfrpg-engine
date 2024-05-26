# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::Player, :model do
  describe 'validations' do
    subject(:player) { build(:player) }

    it do
      game = player.game
      is_expected.to belong_to(:game).required(true)
      player.game = game

      user_role = player.user_role
      is_expected.to belong_to(:user_role).required(true)
      player.user_role = user_role
    end
  end
end
