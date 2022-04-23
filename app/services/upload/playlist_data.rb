# frozen_string_literal: true

module Upload
  class PlaylistData < BaseService
    def run(file, playlist_data_import)
      load(file).map do |row|
        Factory::PlaylistData.new(row, playlist_data_import).create
      end
    rescue CSV::MalformedCSVError
      false
    end
  end
end
