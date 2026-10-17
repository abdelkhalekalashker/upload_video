class Video < ApplicationRecord
  CONTENT_TYPES = %w[video/mp4 video/webm video/ogg video/quicktime].freeze

  has_one_attached :clip

  validates :title, presence: true
  validates :clip, attachment: { content_types: CONTENT_TYPES, max_size: 200.megabytes }
end
