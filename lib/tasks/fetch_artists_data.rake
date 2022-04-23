# frozen_string_literal: true

require 'rspotify'

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

  desc 'Downloads timeline files for all artists'
  task download_timeline_files: :environment do
    check_date_for_schedule(3)

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
    check_date_for_schedule(1)

    artist = Artist.find(1)
    puts "starting Download for #{artist.name}"

    playlist_downloader = Download::PlaylistData.new(artist)
    playlist_downloader.call

    puts 'Ran download'
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

  def check_date_for_schedule(day_of_month)
    # Adapt task to only run on a given day of month on scheduler
    abort("Exiting: Not day #{day_of_month} of the month") if Date.today.day != day_of_month
  end
end
