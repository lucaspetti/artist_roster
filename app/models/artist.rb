# frozen_string_literal: true

class Artist < ApplicationRecord
  include ApplicationHelper

  has_many :playlist_data
  has_many :monthly_streamings

  rails_admin do
    edit do
      field :name
      field :followers do
        read_only true
      end
      field :popularity do
        read_only true
      end
    end

    show do
      field :name
      field :followers
      field :spotify_id
      field :popularity
      field :latest_streaming_data do
        label 'Latest Streaming Data'
        pretty_value do
          value.join.html_safe
        end
      end
    end
  end

  def latest_streaming_data
    monthly_streamings.first(3).map do |data|
      streams_data_html(data)
    end
  end
end
