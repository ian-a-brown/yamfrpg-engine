# frozen_string_literal: true

Faker::Config.locale = 'en-US' if Rails.env.test? && defined?(Faker)
