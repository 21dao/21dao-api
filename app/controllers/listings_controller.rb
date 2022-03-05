# frozen_string_literal: true

class ListingsController < ApplicationController
  def live_listings
    listings = Listing.where(is_listed: true)
                      .where("lower(name) LIKE ANY ('{#{artist_names}}')")

    listings = limit_and_offset(listings)

    render json: { status: 'success', listings: listings }.to_json
  end
end
