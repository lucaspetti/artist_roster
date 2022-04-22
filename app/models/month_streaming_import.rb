# frozen_string_literal: true

class MonthStreamingImport < ApplicationRecord
  include DataImport

  belongs_to :artist
  has_many :monthly_streamings, dependent: :destroy

  rails_admin do
    edit do
      field :artist
      field :file, :active_storage
    end
  end
end
