# frozen_string_literal: true

require_relative 'solana_rpc_ruby'

SolanaRpcRuby.config do |c|
  # These are options that you can set before using gem:
  #
  # You can use this setting or pass cluster directly, check the docs.
  c.cluster = 'https://ssc-dao.genesysgo.net'

  # This one is mandatory.
  c.json_rpc_version = '2.0'
end
