# frozen_string_literal: true

class User < ApplicationRecord
  has_many :nfts

  serialize :keys, Array

  validates :username, allow_nil: true, uniqueness: { case_sensitive: false }
end
