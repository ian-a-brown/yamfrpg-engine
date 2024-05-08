# frozen_string_literal: true

require 'rails_helper'

RSpec.describe :yamfrpg_engine_user, :model do
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
      is_expected.to have_many(:phone_numbers).class_name(Yamfrpg::Engine::PhoneNumber.to_s).through(:user_phone_number)
    end
  end
end
