class AddDataToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :twitter, :string
    add_column :users, :exchange, :string
    add_column :users, :formfunction, :string
    add_column :users, :holaplex, :string
  end
end
