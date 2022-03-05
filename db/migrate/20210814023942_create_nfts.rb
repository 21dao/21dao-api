class CreateNfts < ActiveRecord::Migration[6.1]
  def change
    create_table :nfts do |t|
      t.belongs_to :user
      t.text :metadata
      t.string :mint
      t.boolean :visible, default: true
      t.integer :order_id
      t.timestamps
    end
  end
end
