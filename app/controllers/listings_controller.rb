# frozen_string_literal: true

class ListingsController < ApplicationController
  def all
    listings = Listing.where(is_listed: true)
    render json: { status: 'success', listings: listings }.to_json
  end
end
