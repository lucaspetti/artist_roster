# frozen_string_literal: true

class PlaylistDataImport < ApplicationRecord
  include DataImport

  belongs_to :artist
  belongs_to :user
  has_many :playlist_data, dependent: :destroy

  validates :month, :year, presence: true

  rails_admin do
    edit do
      field :artist
      field :month
      field :year
      field :file, :active_storage
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end
end
