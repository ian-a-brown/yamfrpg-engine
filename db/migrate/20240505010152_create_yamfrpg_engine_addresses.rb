# frozen_string_literal: true

# Migration to create the table for the address model of YAMFRPG.
class CreateYamfrpgEngineAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :yamfrpg_engine_addresses do |t|
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :region
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end
