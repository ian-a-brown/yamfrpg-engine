# frozen_string_literal: true

module Yamfrpg
  module Engine
    # User model for the YAMFRPG engine.
    class User < ApplicationRecord
      belongs_to :address, class_name: Yamfrpg::Engine::Address.to_s, required: false
      belongs_to :person_name, class_name: Yamfrpg::Engine::PersonName.to_s, required: false

      has_many :user_phone_numbers,
               autosave: true,
               class_name: Yamfrpg::Engine::UserPhoneNumber.to_s,
               dependent: :destroy,
               validate: true
      has_many :phone_numbers, class_name: Yamfrpg::Engine::PhoneNumber.to_s, through: :user_phone_numbers

      # Include default devise modules. Others available are:
      # :confirmable, :expirable, :password_archivable, :password_expirable, :secure_validatable, :validatable.
      devise :database_authenticatable,
             :lockable,
             :omniauthable,
             :registerable,
             :recoverable,
             :rememberable,
             :timeoutable
    end
  end
end
