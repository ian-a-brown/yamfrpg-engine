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
      let!(:given_first_surname) { create(:person_name, :given_first_surname) }
      let!(:given_first_suffix) { create(:person_name, :given_first_suffix) }
      let!(:given_first_full) { create(:person_name, :given_first_full) }
      let!(:given_first_full_suffix) { create(:person_name, :given_first_full_suffix) }
      let!(:surname_first_given) { create(:person_name, :surname_first_given) }
      let!(:surname_first_suffix) { create(:person_name, :surname_first_suffix) }
      let!(:surname_first_full) { create(:person_name, :surname_first_full) }
      let!(:surname_first_full_suffix) { create(:person_name, :surname_first_full_suffix) }
      let(:scope) { Yamfrpg::Engine::PersonName.for_name(name, style) }

      context 'given name first' do
        let(:style) { :given_name_first }

        context 'surname only' do
          let(:surname) { given_first_full_suffix.surname }
          let(:name) { surname }
          let(:expected_ids) { Yamfrpg::Engine::PersonName.where(surname:, style:).order(:id).pluck(:id) }

          it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
        end

        context 'given-name and surname' do
          let(:given_name) { given_first_surname.given_name }
          let(:surname) { given_first_surname.surname }
          let(:expected_ids) { Yamfrpg::Engine::PersonName.where(given_name:, surname:, style:).order(:id).pluck(:id) }

          context 'given-name surname' do
            let(:name) { "#{given_name} #{surname}" }

            it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
          end

          context 'surname, given-name' do
            let(:name) { "#{surname}, #{given_name}" }

            it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
          end
        end

        context 'given-name, middle-name, and surname' do
          let(:given_name) { given_first_full.given_name }
          let(:middle_name) { given_first_full.middle_name }
          let(:surname) { given_first_full.surname }
          let(:expected_ids) do
            Yamfrpg::Engine::PersonName.where(given_name:, middle_name:, surname:, style:).order(:id).pluck(:id)
          end

          context 'given-name middle-name surname' do
            let(:name) { "#{given_name} #{middle_name} #{surname}" }

            it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
          end

          context 'surname, given-name middle-name' do
            let(:name) { "#{surname}, #{given_name} #{middle_name}" }

            it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
          end
        end

        context 'full name' do
          let(:given_name) { given_first_full_suffix.given_name }
          let(:middle_name) { given_first_full_suffix.middle_name }
          let(:surname) { given_first_full_suffix.surname }
          let(:suffix) { given_first_full_suffix.suffix }
          let(:expected_ids) do
            Yamfrpg::Engine::PersonName.where(given_name:, middle_name:, surname:, suffix:, style:)
                                       .order(:id)
                                       .pluck(:id)
          end

          context 'given-name middle-name surname suffix' do
            let(:name) { "#{given_name} #{middle_name} #{surname} #{suffix}" }

            it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
          end

          context 'surname suffix, given-name middle-name' do
            let(:name) { "#{surname} #{suffix}, #{given_name} #{middle_name}" }

            it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
          end
        end
      end

      context 'surname first' do
        let(:style) { :surname_first }

        context 'surname only' do
          let(:surname) { surname_first_full_suffix.surname }
          let(:name) { surname }
          let(:expected_ids) { Yamfrpg::Engine::PersonName.where(surname:, style:).order(:id).pluck(:id) }

          it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
        end

        context 'given-name and surname' do
          let(:given_name) { surname_first_given.given_name }
          let(:surname) { surname_first_given.surname }
          let(:expected_ids) { Yamfrpg::Engine::PersonName.where(given_name:, surname:, style:).order(:id).pluck(:id) }
          let(:name) { "#{surname} #{given_name}" }

          it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
        end

        context 'given-name, middle-name, and surname' do
          let(:given_name) { surname_first_full.given_name }
          let(:middle_name) { surname_first_full.middle_name }
          let(:surname) { surname_first_full.surname }
          let(:expected_ids) do
            Yamfrpg::Engine::PersonName.where(given_name:, middle_name:, surname:, style:).order(:id).pluck(:id)
          end
          let(:name) { "#{surname} #{given_name} #{middle_name}" }

          it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
        end

        context 'full name' do
          let(:given_name) { surname_first_full_suffix.given_name }
          let(:middle_name) { surname_first_full_suffix.middle_name }
          let(:surname) { surname_first_full_suffix.surname }
          let(:suffix) { surname_first_full_suffix.suffix }
          let(:expected_ids) do
            Yamfrpg::Engine::PersonName.where(given_name:, middle_name:, surname:, suffix:, style:)
                                       .order(:id)
                                       .pluck(:id)
          end
          let(:name) { "#{surname} #{suffix} #{given_name} #{middle_name}" }

          it { is_expected.to match_array(expected_ids), "#{name}: expected: #{expected_ids}, actual: #{matched}" }
        end
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
