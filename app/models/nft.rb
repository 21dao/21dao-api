# frozen_string_literal: true

class Nft < ApplicationRecord
  belongs_to :user

  serialize :metadata
end
