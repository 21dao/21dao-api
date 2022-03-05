class AddFinalizedToAuctions < ActiveRecord::Migration[6.1]
  def change
    add_column :auctions, :finalized, :boolean, default: false
  end
end
