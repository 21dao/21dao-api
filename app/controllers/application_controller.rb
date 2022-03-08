# frozen_string_literal: true

class ApplicationController < ActionController::API
  def artist_names
    params[:names].map do |s|
      "%#{s.downcase.gsub(' ', '%')}%"
    end.join(',')
  end

  def check_marketplaces
    return true if params[:marketplace] - MARKETPLACES == []

    false
  rescue StandardError
    false
  end

  def days
    if params[:days] && DAYS.include?(params[:days].to_i)
      params[:days].to_i
    else
      1
    end
  end

  def limit_and_offset(auctions)
    auctions = auctions.limit(params[:limit].to_i) if params[:limit]
    auctions = auctions.offset(params[:offset].to_i) if params[:offset]
    auctions
  end

  def order_all_auctions(auctions)
    case params[:order]
    when "ending"
      auctions.order(end_time: :asc)
    when "most_bids"
      auctions.order("number_bids desc")
    when "least_bids"
      auctions.order("number_bids asc, end_time asc")
    when "highest"
      auctions.where("highest_bid IS NOT NULL").order("highest_bid desc")
    when "lowest"
      auctions.order("highest_bid asc")
    else auctions
    end
  end
end
