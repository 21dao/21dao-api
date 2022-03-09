# frozen_string_literal: true

class Artist < ApplicationRecord
  serialize :tags
  serialize :images
end
