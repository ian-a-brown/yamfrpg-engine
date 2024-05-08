# frozen_string_literal: true

FactoryBot.define do
  factory :person_name, class: Yamfrpg::Engine::PersonName do
    given_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    surname { Faker::Name.last_name }
    style { PersonNameFactoryHelper.new.style }
  end
end

# Helper class for the person name factory.
class PersonNameFactoryHelper
  def style
    idx = Faker::Number.between(from: 0, to: Yamfrpg::Engine::PersonName.styles.length - 1)
    Yamfrpg::Engine::PersonName.styles.keys[idx]
  end
end
