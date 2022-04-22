# frozen_string_literal: true

class PlaylistDatum < ApplicationRecord
  belongs_to :playlist
  belongs_to :artist
  belongs_to :playlist_data_import

  validates :month, presence: true
  validates :year, presence: true

  default_scope { reorder(year: :desc, month: :desc) }

  rails_admin do
    list do
      field :playlist
      field :month
      field :year
      field :streams
      field :listeners
      field :followers
      field :artist
    end
  end
end
