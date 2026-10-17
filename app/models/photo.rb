class Photo < ApplicationRecord
  CONTENT_TYPES = %w[image/png image/jpeg image/gif image/webp].freeze

  has_one_attached :image

  validates :title, presence: true
  validates :image, attachment: { content_types: CONTENT_TYPES, max_size: 10.megabytes }
end
