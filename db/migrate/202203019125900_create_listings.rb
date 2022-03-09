class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :mint
      t.boolean :is_listed
      t.timestamp :last_listed
      t.string :listed_by
      t.integer :last_sale_price, limit: 5
      t.integer :last_listed_price, limit: 5
      t.string :image
      t.string :name
      t.string :description
      t.string :title
      t.boolean :cdn_uploaded, default: false
      t.timestamps
    end
    add_index :listings, :name
  end
end
