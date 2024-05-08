# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Base class for YAMFRPG models.
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
