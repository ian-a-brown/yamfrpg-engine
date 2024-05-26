# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::Game, :model do
  describe 'validations' do
    subject(:game) { build(:game) }

    it do
      is_expected.to have_many(:game_masters)
      is_expected.to have_many(:players)
    end
  end
end
