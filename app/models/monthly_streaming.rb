# frozen_string_literal: true

class MonthlyStreaming < ApplicationRecord
  belongs_to :month_streaming_import

  default_scope { reorder(year: :desc, month: :desc) }
  scope :current_year, -> { where(year: Date.today.year) }
end
