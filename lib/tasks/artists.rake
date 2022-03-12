# frozen_string_literal: true

require 'json'

namespace :artists do
  task import: :environment do
    artists = JSON.parse(File.read('artists.json'))
    artists.each do |a|
      Artist.create!(
        name: a['name'],
        twitter: a['twitter'],
        bio: a['bio'],
        tags: a['tags'],
        exchange: a['exchange'],
        holaplex: a['holaplex'],
        formfunction: a['formfunction'],
        images: a['images']
      )
    end
  end
end
