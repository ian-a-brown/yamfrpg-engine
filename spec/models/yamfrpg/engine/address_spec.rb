# frozen_string_literal: true

require 'rails_helper'

RSpec.describe :yamfrpg_engine_address, :model do
  describe 'validations' do
    subject(:address) { build(:address) }

    context 'shoulda' do
      it do
        is_expected.to have_many(:users).class_name(Yamfrpg::Engine::User.to_s)
      end
    end
  end
end
