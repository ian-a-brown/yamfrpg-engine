# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Model representing a phone number for a user in YAMFRPG.
    class UserPhoneNumber < ApplicationRecord
      belongs_to :user, class_name: Yamfrpg::Engine::User.to_s
      belongs_to :phone_number, class_name: Yamfrpg::Engine::PhoneNumber.to_s

      enum kind: %i[home cell work]

      validates_presence_of :kind
    end
  end
end
