# frozen_string_literal: true

module Factory
  class BaseService
    def initialize(csv_row, data_import)
      @row = csv_row.to_h
      @data_import = data_import
    end

    private

    def artist_id
      @data_import.artist_id
    end

    def get_matching_key(key)
      @row.keys.select { |k| k.match(key) }.first
    end

    def value_for(key)
      @row[get_matching_key(key)]
    end

    def parse_date(date, format)
      Date.strptime(date, format)
    end
  end
end
