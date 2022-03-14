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
      t.text :public_keys
      t.boolean :dao, default: false
      t.string :api_key
      t.boolean :loading, default: false
      t.string :nonce
      t.timestamps
    end
  end
end
