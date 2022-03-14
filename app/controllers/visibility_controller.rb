# frozen_string_literal: true

class VisibilityController < ApplicationController
  def set_visibility_and_order
    user = Artist.find_by_api_key(params[:api_key])
    return render json: { status: 'error', msg: 'Api key not valid' } unless user

    params[:tokens].each do |token|
      nft = Nft.find_by(artist_id: user.id, mint: token['mint'])
      nft.visible = token['visible']
      nft.order_id = token['visible'] ? token['order_id'] : nil
      nft.save
    end

    render json: { status: 'success' }
  end
end
