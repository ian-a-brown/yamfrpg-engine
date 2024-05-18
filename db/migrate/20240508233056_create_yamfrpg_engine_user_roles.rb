# frozen_string_literal: true

# Migration to create the table for the user role model of YAMFRPG.
class CreateYamfrpgEngineUserRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_user_roles do |t|
      t.references :user, null: false, foreign_key: { to_table: :yamfrpg_engine_users }
      t.integer :role, null: false

      t.timestamps
    end
  end
end
