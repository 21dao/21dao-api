# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'yaml'

artists = JSON.parse(File.read('./db/artists.json'))
artists.each do |row|
  row['tags'] = YAML.safe_load(row['tags'])
  row['images'] = YAML.safe_load(row['images'])
end
Artist.create(artists)

listings = JSON.parse(File.read('./db/listings.json'))
Listing.create(listings)

auctions = JSON.parse(File.read('./db/auctions.json'))
Auction.create(auctions)
