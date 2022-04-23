# frozen_string_literal: true

class Release < ApplicationRecord
  belongs_to :artist

  validates :release_type, :title, presence: true

  rails_admin do
    list do
      field :title
      field :artist
      field :release_type
      field :released_at
    end
  end
end
