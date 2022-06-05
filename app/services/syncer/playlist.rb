# frozen_string_literal: true

module Syncer
  class Playlist
    def sync_playlists
      ::Playlist.all.each do |playlist|
        next if playlist.spotify_id.nil? && playlist.author == 'Spotify'

        if playlist.spotify_id
          playlist_spotify_data = RSpotify::Playlist.find(playlist.author, playlist.spotify_id)
        else
          search_results = RSpotify::Playlist.search(playlist.name)
          playlist_spotify_data = search_results.filter do |result|
            result.name == playlist.name && result.owner.display_name == playlist.author
          end.first
        end

        next if playlist_spotify_data.nil?

        updater = Updater::PlaylistData.new(playlist_spotify_data)
        updater.update!
      end
    end
  end
end
