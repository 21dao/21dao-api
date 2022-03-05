class CreateAuctions < ActiveRecord::Migration[6.1]
  def change
    create_table :auctions do |t|
      t.integer :start_time, limit: 5
      t.integer :end_time, limit: 5
      t.integer :reserve, limit: 5
      t.integer :min_increment, limit: 5
      t.integer :ending_phase, limit: 5
      t.integer :extension, limit: 5
      t.integer :highest_bid, limit: 5
      t.string :highest_bidder
      t.integer :number_bids
      t.string :auction_account
      t.string :mint
      t.string :brand_id
      t.string :brand_name
      t.string :collection_id
      t.string :collection_name
      t.string :image
      t.string :name
      t.string :source
      t.string :metadata_uri
      t.string :highest_bidder_username
      t.timestamps
    end
    add_index :auctions, :start_time
    add_index :auctions, :end_time
    add_index :auctions, :auction_account
    add_index :auctions, :brand_id
    add_index :auctions, :brand_name
  end
end
