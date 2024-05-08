# frozen_string_literal: true

require 'rails_helper'

RSpec.describe :yamfrpg_engine_person_name, :model do
  describe 'validations' do
    subject(:person_name) { build(:person_name) }

    it do
      is_expected.to have_one(:user).required(false)

      given_name = person_name.given_name
      is_expected.to validate_presence_of(:given_name)
      person_name.given_name = given_name

      surname = person_name.surname
      is_expected.to validate_presence_of(:surname)
      person_name.surname = surname

      style = person_name.style
      is_expected.to validate_presence_of(:style)
      person_name.style = style

      is_expected.to have_one(:user).class_name(Yamfrpg::Engine::User.to_s)
    end
  end
end
