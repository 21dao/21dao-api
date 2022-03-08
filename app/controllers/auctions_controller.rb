# frozen_string_literal: true

MARKETPLACES = %w[holaplex exchange formfunction].freeze
DAYS = [1, 7].freeze

class AuctionsController < ApplicationController
  def all_by_artists
    auctions = Auction.where("start_time < #{Time.now.to_i} AND end_time > #{Time.now.to_i}")
                      .where("lower(brand_name) LIKE ANY ('{#{artist_names}}')")
                      .where("mint IS NOT NULL AND image IS NOT NULL")

    auctions = auctions.where(source: params[:marketplace]) if check_marketplaces

    auctions = limit_and_offset(auctions)

    render json: { status: 'success', auctions: auctions }.to_json
  end

  def all
    auctions = Auction.where("end_time > #{Time.now.to_i}")
                      .where("mint IS NOT NULL AND image IS NOT NULL")

    auctions = auctions.where(source: params[:marketplace]) if check_marketplaces

    auctions = limit_and_offset(auctions)

    auctions = order_all_auctions(auctions)

    render json: { status: 'success', auctions: auctions }.to_json
  end

  def top_sales
    auctions = Auction.where("end_time > #{(Time.now - days.day).to_i}")
                      .where("end_time < #{Time.now.to_i}")
                      .where("highest_bid >= reserve")
                      .where("mint IS NOT NULL AND image IS NOT NULL")
                      .order(highest_bid: :desc)

    auctions = auctions.where(source: params[:marketplace]) if check_marketplaces

    auctions = limit_and_offset(auctions)

    render json: { status: 'success', auctions: auctions }.to_json
  end

  def top_sellers
    auctions = Auction.select("brand_name, source, COUNT(*) as auctions, SUM(number_bids) as bids, SUM(highest_bid) as total")
                      .where("end_time > #{(Time.now - days.day).to_i}")
                      .where("end_time < #{Time.now.to_i}")
                      .where("highest_bid >= reserve")
                      .where("mint IS NOT NULL AND image IS NOT NULL")
                      .order(total: :desc)
                      .order(bids: :desc)
                      .group(:brand_name, :source)

    auctions = auctions.where(source: params[:marketplace]) if check_marketplaces

    auctions = limit_and_offset(auctions)

    render json: { status: 'success', auctions: auctions }.to_json
  end

  def top_buyers
    auctions = Auction.select("highest_bidder, COUNT(*) as auctions, SUM(number_bids) as bids, SUM(highest_bid) as total")
                      .where("highest_bidder IS NOT NULL")
                      .where("end_time > #{(Time.now - days.day).to_i}")
                      .where("end_time < #{Time.now.to_i}")
                      .where("highest_bid >= reserve")
                      .where("mint IS NOT NULL AND image IS NOT NULL")
                      .order(total: :desc)
                      .order(bids: :desc)
                      .group(:highest_bidder)

    auctions = auctions.where(source: params[:marketplace]) if check_marketplaces

    auctions = limit_and_offset(auctions)

    render json: { status: 'success', auctions: auctions }.to_json
  end
end
