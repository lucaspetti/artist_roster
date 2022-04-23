# frozen_string_literal: true

require 'rspotify'

namespace :sync_artists do
  desc 'Fetches data for artists from Spotify'
  task fetch_data: :environment do
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

  desc 'Downloads timeline files for all artists'
  task download_timeline_files: :environment do
    puts 'Starting downloads for artists with spotify ID...'

    Artist.where.not(spotify_id: nil).each do |artist|
      puts "Downloading timeline file for #{artist.name}..."

      timeline_downloader = Download::Timeline.new(artist)
      timeline_downloader.call

      puts 'Ran download'
    end

    puts 'Done.'
  end

  desc 'Downloads playlist file for one artist'
  task download_playlist_file: :environment do
    artist = Artist.find(1)
    puts "starting Download for #{artist.name}"

    playlist_downloader = Download::PlaylistData.new(artist)
    playlist_downloader.call

    puts 'Ran download'
  end

  desc 'Syncs artist releases'
  task releases: :environment do
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
