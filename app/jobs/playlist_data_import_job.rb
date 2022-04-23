# frozen_string_literal: true

class PlaylistDataImportJob < ApplicationJob
  def perform(id)
    data_import = PlaylistDataImport.find(id)

    Upload::PlaylistData.run(
      data_import.file.download, data_import
    )
    data_import.update(ran_at: Time.zone.now)
  end
end
