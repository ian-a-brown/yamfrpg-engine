# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::UserPolicy, :policy do
  describe 'policy_scope' do
    [
      { role: :administrator, expected_keys: %i[current_user administrator game_master player] },
      { role: :game_master, expected_keys: %i[current_user] },
      { role: :player, expected_keys: %i[current_user] }
    ].each do |role_scope|
      context role_scope[:role].to_s.humanize do
        let(:role) { role_scope[:role] }
        let(:user) { create(:user, role) }
        let!(:available_models) do
          {}.tap do |user_hash|
            user_hash[:current_user] = user
            user_hash[:administrator] = create(:user, :administrator)
            user_hash[:game_master] = create(:user, :game_master)
            user_hash[:player] = create(:user, :player)
          end
        end

        before(:each) { Kernel.puts "Before run: #{Yamfrpg::Engine::User.count}" }

        subject(:scope) do
          Yamfrpg::Engine::UserPolicy::Scope.new(user, Yamfrpg::Engine::User).resolve.order(:id).pluck(:id)
        end

        include_examples 'policy#scope', role_scope[:expected_keys]
      end
    end
  end
end
