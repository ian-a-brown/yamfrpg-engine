# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Model representing a phone number of YAMFRPG.
    class PhoneNumber < ApplicationRecord
      has_many :user_phone_numbers, class_name: Yamfrpg::Engine::UserPhoneNumber.to_s
      has_many :users, class_name: Yamfrpg::Engine::User.to_s, through: :user_phone_numbers

      validates :number, presence: true
    end
  end
end
