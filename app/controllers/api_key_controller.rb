# frozen_string_literal: true

require_relative '../lib/btc'

class ApiKeyController < ApplicationController
  def request_api_key
    nonce = SecureRandom.hex(4)

    unless (user = Artist.where("public_keys LIKE '%#{params[:public_key]}%'").first)
      user = Artist.create(public_keys: [params[:public_key]])
    end

    user.nonce = nonce
    user.save!

    render json: { status: 'success', nonce: nonce }
  end

  def create_api_key
    user = Artist.where("public_keys LIKE '%#{params[:public_key]}%'").first
    return render json: { status: 'error', msg: 'Public key not found' } unless user

    return render json: { status: 'error', msg: 'Signature verifcation failed' } unless verify_signature(
      params[:public_key], user.nonce
    )

    user.api_key = SecureRandom.hex(16)

    unless user.loading
      user.loading = true
      UpdateUserNftsJob.perform_later(user.id)
    end

    user.save!

    render json: { status: 'success', api_key: user.api_key }
  end

  private

  def verify_signature(public_key, nonce)
    verify_key = RbNaCl::VerifyKey.new(decode_base58(public_key))
    signature = params[:signature]['data'].pack('c*')
    message = "#{Rails.configuration.sign_message}#{nonce}"
    Rails.logger.debug message
    verify_key.verify(signature, message)
  rescue RbNaCl::BadSignatureError
    false
  end

  def decode_base58(str)
    Btc::Base58.data_from_base58 str
  end
end