# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::GameMaster, :model do
  describe 'validations' do
    subject(:game_master) { build(:game_master) }

    it do
      game = game_master.game
      is_expected.to belong_to(:game).required(true)
      game_master.game = game

      user_role = game_master.user_role
      is_expected.to belong_to(:user_role).required(true)
      game_master.user_role = user_role

      is_expected.to validate_uniqueness_of(:owner).scoped_to(:game_id)
    end
  end
end
