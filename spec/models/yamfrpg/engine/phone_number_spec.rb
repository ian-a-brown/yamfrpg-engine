# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::PhoneNumber, :model do
  describe 'validations' do
    subject(:phone_number) { build(:phone_number) }

    context 'shoulda' do
      it do
        is_expected.to have_many(:user_phone_numbers).class_name(Yamfrpg::Engine::UserPhoneNumber.to_s)
        is_expected.to have_many(:users).class_name(Yamfrpg::Engine::User.to_s).through(:user_phone_numbers)

        number = phone_number.number
        is_expected.to validate_presence_of(:number)
        phone_number.number = number
      end
    end
  end
end
