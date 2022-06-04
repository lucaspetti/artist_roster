# frozen_string_literal: true

module Updater
  class PlaylistData
    def initialize(playlist_spotify_data)
      @playlist_spotify_data = playlist_spotify_data
    end

    def update!
      playlist = Playlist.find_by_name!(@playlist_spotify_data.name)
      playlist_data = PlaylistDatum.where(playlist: playlist).last
      raise 'Playlist Data not found' if playlist_data.nil?

      playlist_data.update!(followers: @playlist_spotify_data.followers['total'])
      playlist.update!(mapped_attributes)
    end

    def mapped_attributes
      {
        description: @playlist_spotify_data.description,
        spotify_id: @playlist_spotify_data.id
      }
    end
  end
end
