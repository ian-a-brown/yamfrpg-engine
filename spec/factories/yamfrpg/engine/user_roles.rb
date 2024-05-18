# frozen_string_literal: true

FactoryBot.define do
  factory :user_role, class: Yamfrpg::Engine::UserRole do
    association :user, strategy: :create

    role { UserRoleFactoryHelper.new.role }
  end
end

# Helper class for the user role factory.
class UserRoleFactoryHelper
  def role
    idx = Faker::Number.between(from: 0, to: Yamfrpg::Engine::UserRole.roles.length - 1)
    Yamfrpg::Engine::UserRole.roles.keys[idx]
  end
end
