# frozen_string_literal: true

module Updater
  class ArtistReleases
    def initialize(artist)
      @artist = artist
    end

    def update!(releases)
      releases.each do |release|
        record = Release.find_or_initialize_by(
          title: release.name, artist_id: @artist.id
        )

        attributes = mapped_attributes(release)
        record.update!(attributes)
      end
    end

    private

    def mapped_attributes(release)
      {
        spotify_id: release.id,
        released_at: release.release_date,
        image_url: release.images.first['url'],
        release_type: release.album_type
      }
    end
  end
end
