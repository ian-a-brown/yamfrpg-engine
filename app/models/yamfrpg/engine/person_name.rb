# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Model representing the name of a person in YAMFRPG.
    class PersonName < ApplicationRecord
      enum style: %i[given_name_first surname_first]

      has_one :user, class_name: Yamfrpg::Engine::User.to_s, required: false

      validates_presence_of :given_name
      validates_presence_of :surname
      validates_presence_of :style
    end
  end
end
