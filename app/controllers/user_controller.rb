# frozen_string_literal: true

class UserController < ApplicationController
  def from_api_key
    return render json: { status: 'error', msg: 'API key not found' } if params[:api_key].nil?

    user = Artist.find_by_api_key([params[:api_key]])
    return render json: { status: 'error', msg: 'API key not found' } unless user

    render json: { status: 'success', user: user, nfts: user.nfts.where(edition: [2, 6]) }.to_json
  end

  def nfts
    user = Artist.find_by_name(params[:username])
    return render json: { status: 'error', msg: 'Username not found' } unless user

    render json: { status: 'success', user: user, nfts: user.nfts.where(visible: true, edition: [2, 6]) }.to_json
  end

  def refresh
    user = Artist.find_by_api_key(params[:api_key])
    return render json: { status: 'error', msg: 'Api key not valid' } unless user

    unless user.loading
      user.loading = true
      user.save!
      UpdateUserNftsJob.perform_later(user.id)
    end

    render json: { status: 'success' }
  end

  def update_data
    user = Artist.find_by_api_key(params[:api_key])
    return render json: { status: 'error', msg: 'Api key not valid' } unless user

    return render json: { status: 'error', msg: 'Username is blank' } if params[:data][:username].empty?

    user.name = params[:data][:username]
    user.twitter = params[:data][:twitter]
    user.exchange = params[:data][:exchange]
    user.formfunction = params[:data][:formfunction]
    user.holaplex = params[:data][:holaplex]
    user.save

    return render json: { status: 'success', user: user } if user.valid?

    render json: { status: 'error', msg: user.errors.full_messages.join(', ') }
  end
end
