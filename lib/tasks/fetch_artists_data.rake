# frozen_string_literal: true

require 'rspotify'
require 'helpers'

include Helpers

namespace :sync_artists do
  desc 'Fetches data for artists from Spotify'
  task fetch_data: :environment do
    check_date_for_schedule(1)

    print 'Authenticating...'
    RSpotify.authenticate(ENV['SPOTIFY_APP_CLIENT_ID'], ENV['SPOTIFY_APP_CLIENT_SECRET'])
    puts 'Done'

    Artist.all.each do |artist|
      puts "Fetching data for #{artist.name}..."

      if artist.spotify_id
        artist_data = RSpotify::Artist.find(artist.spotify_id)
      else
        search_results = RSpotify::Artist.search(artist.name)

        search_results.each do |result|
          next if result.name != artist.name

          artist_data = result
        end
      end

      next unless artist_data

      puts 'Updating artist data...'
      Updater::ArtistData.new(artist_data).update!
    end
  end

  desc 'Syncs artist releases'
  task releases: :environment do
    check_date_for_schedule(2)

    print 'Authenticating...'
    RSpotify.authenticate(ENV['SPOTIFY_APP_CLIENT_ID'], ENV['SPOTIFY_APP_CLIENT_SECRET'])
    puts 'Done'

    Artist.where.not(spotify_id: nil).each do |artist|
      puts "Fetching data for #{artist.name}..."

      releases = RSpotify::Artist.find(artist.spotify_id).albums

      next if releases.empty?

      puts 'Updating artist releases...'
      releases_updater = Updater::ArtistReleases.new(artist)
      releases_updater.update!(releases)
    end

    puts 'Done.'
  end
end
