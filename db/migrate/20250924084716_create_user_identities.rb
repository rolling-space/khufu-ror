# frozen_string_literal: true

class CreateUserIdentities < ActiveRecord::Migration[8.0]
  def change
    create_table :user_identities, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :uid
      t.string :provider
      t.jsonb :meta_info
      t.text :info
      t.string :token
      t.string :refresh_token
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :user_identities, [:provider, :uid], unique: true
    add_index :user_identities, :token, unique: true
    add_index :user_identities, :refresh_token, unique: true
  end
end
