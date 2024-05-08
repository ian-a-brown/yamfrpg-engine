# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Module repsenting an address in YAMFRPG.
    class Address < ApplicationRecord
      has_many :users, class_name: Yamfrpg::Engine::User.to_s
    end
  end
end
