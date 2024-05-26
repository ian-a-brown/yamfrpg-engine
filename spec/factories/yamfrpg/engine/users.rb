# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: Yamfrpg::Engine::User do
    association :address, strategy: :create
    association :person_name, strategy: :create

    email { Faker::Internet.email }
    password { 'P@ssw0rd!' }
    password_confirmation { 'P@ssw0rd!' }

    trait :administrator do
      after(:build) do |user, _|
        user.user_roles << build(:user_role, user: user, role: :administrator) unless user.user_roles.find_by(role: :administrator).present?
      end
    end

    trait :game_master do
      after(:build) do |user, _|
        user.user_roles << build(:user_role, user: user, role: :game_master) unless user.user_roles.find_by(role: :game_master).present?
      end
    end

    trait :player do
      after(:build) do |user, _|
        user.user_roles << build(:user_role, user: user, role: :player) unless user.user_roles.find_by(role: :player).present?
      end
    end
  end
end
