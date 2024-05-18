# frozen_string_literal: true

# Migration to create the table for the phone numbers in the YAMFRPG engine.
class CreateYamfrpgEnginePhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_phone_numbers do |t|
      t.string :number

      t.timestamps

      t.index :number, unique: true
    end
  end
end
