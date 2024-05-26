# frozen_string_literal: true

require 'rails_helper'

# RSpec examples for Pundit policy testing.
module PolicySpecExamples
  RSpec.shared_examples 'policy#scope' do |expected_keys|
    describe '#scope' do
      it do
        expected_results = expected_keys.map { |expected_key| available_models[expected_key] }.map(&:id).sort

        is_expected.to match_array(expected_results)
      end
    end
  end
end
