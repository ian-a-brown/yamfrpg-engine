# frozen_string_literal: true

require 'rails_helper'

RSpec.describe :yamfrpg_engine_user_phone_number, :model do
  describe 'validations' do
    subject(:user_phone_number) { build(:user_phone_number) }

    it do
      phone_number = user_phone_number.phone_number
      is_expected.to belong_to(:phone_number).required(true)
      user_phone_number.phone_number = phone_number

      user = user_phone_number.user
      is_expected.to belong_to(:user).required(true)
      user_phone_number.user = user
    end
  end
end
