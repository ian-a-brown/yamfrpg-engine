# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: Yamfrpg::Engine::User do
    association :address, strategy: :create
    association :person_name, strategy: :create

    email { Faker::Internet.email }
    password { 'P@ssw0rd!' }
    password_confirmation { 'P@ssw0rd!' }
  end
end
