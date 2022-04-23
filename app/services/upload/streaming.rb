# frozen_string_literal: true

module Upload
  class Streaming < BaseService
    def run(file, streaming_import)
      load(file).map do |row|
        next if row.to_h['listeners'] == '0'

        Factory::MonthlyStreaming.new(row, streaming_import).create
      end
    rescue CSV::MalformedCSVError
      false
    end
  end
end
