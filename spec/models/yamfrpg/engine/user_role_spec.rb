# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::UserRole, :model do
  describe 'validations' do
    subject(:user_role) { build(:user_role) }

    it do
      user = user_role.user
      is_expected.to belong_to(:user).required(true)
      user_role.user = user

      other_user_role = create(:user_role, user: user_role.user, role: user_role.role)
      is_expected.to_not be_valid
      other_user_role.destroy!

      is_expected.to have_many(:game_masters)
      is_expected.to have_many(:players)
    end
  end
end
