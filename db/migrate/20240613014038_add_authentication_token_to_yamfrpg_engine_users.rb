# frozen_string_literal: true

# Migration to add an authentication token field to the YAMFRPG users table.
class AddAuthenticationTokenToYamfrpgEngineUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :yamfrpg_engine_users, :authentication_token, :string
  end
end
