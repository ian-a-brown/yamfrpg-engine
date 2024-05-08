# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in yamfrpg-engine.gemspec.
gemspec

group :development, :test do
  gem 'pg'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
