# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Loging session model for YAMFRPG.
    class LoginSession < ApplicationRecord
      belongs_to :user

      validates_uniqueness_of :uuid
      validates_uniqueness_of :token, scope: :uuid

      def expired?
        expires < DateTime.current
      end
    end
  end
end
