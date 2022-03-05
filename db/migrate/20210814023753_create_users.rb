class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.text :keys
      t.string :api_key
      t.string :nonce
      t.boolean :loading, default: false
      t.timestamps
    end
    add_index :users, :keys
    add_index :users, :username
  end
end
