# frozen_string_literal: true

require 'httparty'
require_relative '../lib/btc'
require_relative '../lib/metadata'
require_relative '../lib/edition_data'

class UpdateUserNftsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = Artist.find_by_id(user_id)

    method_wrapper = SolanaRpcRuby::MethodsWrapper.new
    response = method_wrapper.get_program_accounts(
      'metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s',
      encoding: 'jsonParsed',
      filters: [
        { dataSize: 679 },
        {
          memcmp: {
            offset: 326,
            bytes: user.public_keys.first
          }
        }
      ]
    )
    results = response.parsed_response['result']

    results.each do |result|
      data = result['account']['data'][0]
      metadata = Metadata.extract(data)
      resp = HTTParty.get(metadata[:uri]).body
      resp = JSON.parse(resp).symbolize_keys
      nft = user.nfts.where(mint: metadata[:mint]).first_or_create
      nft.metadata = metadata.merge(resp)
      nft.save!
    end

    update_edition_data(user)

    user.update_attribute :loading, false
  end

  def update_edition_data(user)
    user.nfts.each do |nft|
      next if nft.edition

      mint = Btc::Base58.data_from_base58 nft.mint
      mpid = Btc::Base58.data_from_base58 "metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s"
      n = 255
      while n.positive?
        nonce = [n].pack('S').strip
        buf = ['metadata', mpid, mint, 'edition', nonce, mpid, 'ProgramDerivedAddress'].join
        hex = Digest::SHA256.digest buf
        add = Btc::Base58.base58_from_data hex
        if (result = get_account(add))
          data = EditionData.extract(result['data'][0])
          nft.edition = data[:type]
          nft.edition_name = data[:name]
          nft.max_supply = data[:max_supply]
          nft.supply = data[:supply]
          nft.save
          break
        end
        n -= 1
      end
    end
  end

  def get_account(account)
    method_wrapper = SolanaRpcRuby::MethodsWrapper.new
    response = method_wrapper.get_account_info(
      account,
      encoding: 'jsonParsed'
    )
    results = response.parsed_response['result']
    results['value']
  end

  # def on_curve?(s)
  #   unclamped = s.unpack('V*').join.to_i

  #   _decodepoint(unclamped)
  # # _ = _decodepoint(unclamped)
  # rescue StandardError
  #   nil
  # end

  # def _inv(x)
  #   (x ^ (Q - 2)) % Q
  #   # pow(x, Q - 2, Q)
  # end

  # Q = 2**255 - 19
  # L = 2**252 + 27_742_317_777_372_353_535_851_937_790_883_648_493
  # D = -121_665 * 121_666 ^ (Q - 2) % Q
  # # D = -121_665 * pow(121_666, Q - 2, Q)
  # I = (2 ^ (Q - 1) / 4) % Q
  # # I = pow(2, (Q - 1) / 4, Q)

  # def _decodepoint(unclamped)
  #   clamp = (1 << 255) - 1
  #   y = unclamped & clamp
  #   x = _xrecover(y)
  #   x = Q - x if x & 1 != (unclamped & (1 << 255))
  #   p = [x, y]
  #   raise "NotOnCurve" unless _isoncurve(p)

  #   p
  # end

  # def _isoncurve(p)
  #   x = p[0]
  #   y = p[1]
  #   (-x * x + y * y - 1 - D * x * x * y * y) % Q == 0
  # end

  # def _xrecover(y)
  #   xx = (y * y - 1) * _inv(D * y * y + 1)
  #   x = (xx ^ (Q + 3) / 8) % Q
  #   # x = pow(xx, (Q + 3) / 8, Q)
  #   x = (x * I) % Q if (x * x - xx) % Q != 0
  #   x = Q - x if x.odd?
  #   x
  # end
end
