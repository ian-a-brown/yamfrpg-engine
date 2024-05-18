# frozen_string_literal: true

FactoryBot.define do
  factory :game, class: Yamfrpg::Engine::Game do
    association :owner, factory: :user, strategy: :create
    sequence(:name) { |n| "#{owner.name} Game #{n + 1}" }
  end
end
