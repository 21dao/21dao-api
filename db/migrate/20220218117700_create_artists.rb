class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :twitter
      t.text :bio
      t.text :tags
      t.string :exchange
      t.string :holaplex
      t.string :formfunction
      t.text :images
      t.timestamps
    end
    add_index :artists, :directory
  end
end
