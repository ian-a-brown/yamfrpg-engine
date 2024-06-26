# frozen_string_literal: true

# Migration to create the table for the user model of YAMFRPG.
class DeviseCreateYamfrpgEngineUsers < ActiveRecord::Migration[7.1]
  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  def change
    create_table :yamfrpg_engine_users do |t|
      t.references :address, null: true, foreign_key: { to_table: :yamfrpg_engine_addresses }
      t.references :person_name, null: true, foreign_key: { to_table: :yamfrpg_engine_person_names }

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false

      t.index :email, unique: true
      t.index :reset_password_token, unique: true
      t.index :unlock_token, unique: true
    end
    # rubocop: enable Metrics/MethodLength
    # rubocop: enable Metrics/AbcSize
  end
end
