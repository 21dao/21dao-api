# frozen_string_literal: true

class ArtistController < ApplicationController
  def by_name
    artist = Artist.find_by_name(params[:name])
    render json: { status: 'success', artist: artist }.to_json
  end
end
