# frozen_string_literal: true

FactoryBot.define do
  factory :player, class: Yamfrpg::Engine::Player do
    association :user, factory: %i[user player], strategy: :create
    association :game, strategy: :create
  end
end
