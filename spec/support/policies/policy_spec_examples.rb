# frozen_string_literal: true

require 'rails_helper'

# RSpec examples for Pundit policy testing.
module PolicySpecExamples
  RSpec.shared_examples '#scope' do
    describe '#scope' do |expected_keys|
      it do
        expected_results = expected_keys.map { |expected_key| available_models[expected_key] }.sort_by(&:id)

        is_expected.to match_array(expected_results)
      end
    end
  end
end
