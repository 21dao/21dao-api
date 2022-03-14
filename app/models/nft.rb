# frozen_string_literal: true

class Nft < ApplicationRecord
  serialize :metadata
  belongs_to :artist
end
