# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Yamfrpg::Engine::User, :model do
  describe 'validations' do
    subject(:user) { build(:user) }

    it do
      address = user.address
      is_expected.to belong_to(:address).required(false)
      user.address = address

      person_name = user.person_name
      is_expected.to belong_to(:person_name).required(false)
      user.person_name = person_name

      is_expected.to have_many(:user_phone_numbers).class_name(Yamfrpg::Engine::UserPhoneNumber.to_s)
      is_expected.to have_many(:phone_numbers).class_name(Yamfrpg::Engine::PhoneNumber.to_s)
                                              .through(:user_phone_numbers)

      is_expected.to have_many(:user_roles).class_name(Yamfrpg::Engine::UserRole.to_s)
    end
  end

  describe '#administrator?' do
    subject(:is_administrator) { user.administrator? }

    {
      administrator: { role: :administrator, is_administrator: true },
      game_master: { role: :game_master, is_administrator: false },
      player: { role: :player, is_administrator: false }
    }.each do |user_type, user_description|
      context user_type.to_s.humanize do
        let(:user) { create(:user, user_description[:role]) }

        it { is_expected.to eq(user_description[:is_administrator]) }
      end
    end
  end

  describe '#game_master?' do
    subject(:is_game_master) { user.game_master? }

    {
      administrator: { role: :administrator, is_game_master: false },
      game_master: { role: :game_master, is_game_master: true },
      player: { role: :player, is_game_master: false }
    }.each do |user_type, user_description|
      context user_type.to_s.humanize do
        let(:user) { create(:user, user_description[:role]) }

        it { is_expected.to eq(user_description[:is_game_master]) }
      end
    end
  end

  describe '#player?' do
    subject(:is_player) { user.player? }

    {
      administrator: { role: :administrator, is_player: false },
      game_master: { role: :game_master, is_player: false },
      player: { role: :player, is_player: true }
    }.each do |user_type, user_description|
      context user_type.to_s.humanize do
        let(:user) { create(:user, user_description[:role]) }

        it { is_expected.to eq(user_description[:is_player]) }
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
