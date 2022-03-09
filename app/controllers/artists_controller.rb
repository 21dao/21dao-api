# frozen_string_literal: true

class ArtistsController < ApplicationController
  def all
    artists = Artist.all
    render json: { status: 'success', artists: artists }.to_json
  end
end
