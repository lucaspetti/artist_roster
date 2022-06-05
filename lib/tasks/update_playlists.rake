# frozen_string_literal: true

require 'rspotify'
require 'helpers'

include Helpers

namespace :update_playlists do
  desc 'Fetches data for artists from Spotify'
  task fetch_data: :environment do
    check_date_for_schedule(5)

    print 'Authenticating...'
    RSpotify.authenticate(ENV['SPOTIFY_APP_CLIENT_ID'], ENV['SPOTIFY_APP_CLIENT_SECRET'])
    puts 'Done'

    puts 'Updating playlists id and followers...'
    playlist_syncer = Syncer::Playlist.new
    playlist_syncer.sync_playlists
    puts 'Done'
  end
end
