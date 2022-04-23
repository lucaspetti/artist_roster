# frozen_string_literal: true

class MonthStreamingImportJob < ApplicationJob
  def perform(id)
    streaming_import = MonthStreamingImport.find(id)

    Upload::Streaming.run(
      streaming_import.file.download, streaming_import
    )
    streaming_import.update(ran_at: Time.zone.now)
  end
end
