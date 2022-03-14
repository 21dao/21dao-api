class CreateNfts < ActiveRecord::Migration[6.1]
  def change
    create_table :nfts do |t|
      t.belongs_to :artist
      t.text :metadata
      t.string :mint
      t.boolean :visible, default: true
      t.integer :order_id
      t.integer :edition
      t.string :edition_name
      t.integer :max_supply
      t.integer :supply
      t.timestamps
    end
  end
end