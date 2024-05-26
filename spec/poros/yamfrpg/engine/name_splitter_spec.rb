# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Yamfrpg::Engine::NameSplitter, :poro do
  describe '#initialize' do
    {
      surname_only_given_first: { name: 'Surname', style: :given_name_first, surname: 'Surname' },
      surname_only_surname_first: { name: 'Surname', style: :surname_first, surname: 'Surname' },
      given_and_surname_given_first: {
        name: 'Given Surname',
        style: :given_name_first,
        given_name: 'Given',
        surname: 'Surname'
      },
      surname_comma_given_given_first: {
        name: 'Surname, Given',
        style: :given_name_first,
        given_name: 'Given',
        surname: 'Surname'
      },
      surname_and_given_surname_first: {
        name: 'Surname Given',
        style: :surname_first,
        given_name: 'Given',
        surname: 'Surname'
      },
      given_middle_and_surname_given_first: {
        name: 'Given Middle Surname',
        style: :given_name_first,
        given_name: 'Given',
        middle_name: 'Middle',
        surname: 'Surname'
      },
      surname_comma_given_middle_given_first: {
        name: 'Surname, Given Middle',
        style: :given_name_first,
        given_name: 'Given',
        middle_name: 'Middle',
        surname: 'Surname'
      },
      surname_given_middle_surname_first: {
        name: 'Surname Given Middle',
        style: :surname_first,
        given_name: 'Given',
        middle_name: 'Middle',
        surname: 'Surname'
      },
      given_surname_suffix_given_first: {
        name: 'Given Surname Sr.',
        style: :given_name_first,
        given_name: 'Given',
        surname: 'Surname',
        suffix: 'Sr.'
      },
      surname_suffix_comma_given_given_first: {
        name: 'Surname Jr., Given',
        style: :given_name_first,
        given_name: 'Given',
        surname: 'Surname',
        suffix: 'Jr.'
      },
      surname_suffix_given_surname_first: {
        name: 'Surname III Given',
        style: :surname_first,
        given_name: 'Given',
        surname: 'Surname',
        suffix: 'III'
      },
      given_middle_surname_suffix_given_first: {
        name: 'Given Middle Surname IV',
        style: :given_name_first,
        given_name: 'Given',
        middle_name: 'Middle',
        surname: 'Surname',
        suffix: 'IV'
      },
      surname_suffix_comma_given_middle_given_first: {
        name: 'Surname V, Given Middle',
        style: :given_name_first,
        given_name: 'Given',
        middle_name: 'Middle',
        surname: 'Surname',
        suffix: 'V'
      },
      surname_suffix_given_middle_surname_first: {
        name: 'Surname VI Given Middle',
        style: :surname_first,
        given_name: 'Given',
        middle_name: 'Middle',
        surname: 'Surname',
        suffix: 'VI'
      }
    }.each do |request, request_description|
      context request.to_s do
        let(:name_splitter) do
          Yamfrpg::Engine::NameSplitter.new(request_description[:name], request_description[:style])
        end

        it do
          expect(name_splitter.name).to eq(request_description[:name])
          expect(name_splitter.style).to eq(request_description[:style])
          expect(name_splitter.given_name).to eq(request_description[:given_name])
          expect(name_splitter.middle_name).to eq(request_description[:middle_name])
          expect(name_splitter.surname).to eq(request_description[:surname])
          expect(name_splitter.suffix).to eq(request_description[:suffix])
        end
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
