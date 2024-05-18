# frozen_string_literal: true

# Migration to create the table for the user phone number model of YAMFRPG.
class CreateYamfrpgEngineUserPhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_user_phone_numbers do |t|
      t.references :phone_number, null: false, index: true, foreign_key: { to_table: :yamfrpg_engine_phone_numbers }
      t.references :user, null: false, index: true, foreign_key: { to_table: :yamfrpg_engine_users }
      t.integer :kind

      t.timestamps

      t.index %i[user_id phone_number_id], unique: true
    end
  end
end
