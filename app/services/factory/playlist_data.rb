# frozen_string_literal: true

module Factory
  class PlaylistData < BaseService
    def create
      ::PlaylistDatum.create!(playlist_data)
    end

    private

    def playlist
      Playlist.find_or_create_by(
        name: value_for('title'), author: value_for('author')
      )
    end

    def playlist_data
      {
        artist_id: artist_id,
        year: @data_import.year,
        month: @data_import.month,
        streams: @row['streams'],
        listeners: @row['listeners'],
        playlist_id: playlist.id,
        playlist_data_import_id: @data_import.id
      }
    end
  end
end
