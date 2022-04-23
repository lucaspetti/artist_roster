# frozen_string_literal: true

module Updater
  class ArtistData
    def initialize(artist_data)
      @artist_data = artist_data
    end

    def update!
      artist = Artist.find_by_name(@artist_data.name)
      artist.update!(mapped_attributes)
    end

    private

    def mapped_attributes
      {
        followers: @artist_data.followers['total'],
        popularity: @artist_data.popularity,
        spotify_id: @artist_data.id
      }
    end
  end
end
