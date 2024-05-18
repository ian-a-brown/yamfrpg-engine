# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Yamfrpg::Engine::PersonName, :model do
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

  describe 'scopes' do
    subject(:matched) { scope.order(:id).pluck(:id) }

    describe '#for_name' do
      let!(:given_first_surname) { create(:yamfrpg_engine_person_name, :given_first_surname) }
      let!(:given_first_suffix) { create(:yamfrpg_engine_person_name, :given_first_suffix) }
      let!(:given_first_full) { create(:yamfrpg_engine_person_name, :given_first_full) }
      let!(:given_first_full_suffix) { create(:yamfrpg_engine_person_name, :given_first_full_suffix) }
      let!(:surname_first_given) { create(:yamfrpg_engine_person_name, :surname_first_given) }
      let!(:surname_first_suffix) { create(:yamfrpg_engine_person_name, :surname_first_suffix) }
      let!(:surname_first_full) { create(:yamfrpg_engine_person_name, :surname_first_full) }
      let!(:surname_first_full_suffix) { create(:yamfrpg_engine_person_name, :surname_first_full_suffix) }
      let(:scope) { Yamfrpg::Engine::PersonName.for_name(name, style) }

      context 'just the surname' do
        let(:name) { given_first_surname.surname }
        let(:expected_ids) do
          Yamfrpg::Engine::PersonName.where(surname:).order(:id).pluck(:id)
        end

        it { is_expected.to match_array(expected_ids) }
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
