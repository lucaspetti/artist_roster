# frozen_string_literal: true

class Playlist < ApplicationRecord
  include ApplicationHelper

  validates :name, presence: true
  validates :author, presence: true

  has_many :playlist_data

  rails_admin do
    show do
      field :name
      field :author
      field :latest_playlist_data do
        label 'Latest Playlist Data'
        pretty_value do
          value.join.html_safe
        end
      end
    end
  end

  def latest_playlist_data
    playlist_data.first(3).map do |data|
      streams_data_html(data)
    end
  end
end
