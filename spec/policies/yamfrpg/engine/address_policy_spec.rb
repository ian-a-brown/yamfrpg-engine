# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::AddressPolicy, :policy do
  let!(:user) { create(:user) }

  [
    { role: :administrator, expected_keys: %i[mine game_master player] }
  ]
end
