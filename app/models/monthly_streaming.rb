# frozen_string_literal: true

class MonthlyStreaming < ApplicationRecord
  belongs_to :artist
  belongs_to :month_streaming_import

  default_scope { reorder(year: :desc, month: :desc) }
  scope :current_year, -> { where(year: Date.today.year) }

  def self.artists
    Artist.where(id: all.pluck(:artist_id).uniq)
  end
end
