# frozen_string_literal: true

# rubocop: disable Lint/EmptyBlock
Yamfrpg::Engine::Engine.routes.draw do
  devise_for :users, class_name: "Yamfrpg::Engine::User"
end
# rubocop: enable Lint/EmptyBlock
