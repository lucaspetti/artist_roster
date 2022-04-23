# frozen_string_literal: true

module Factory
  class MonthlyStreaming < BaseService
    def initialize(csv_row, data_import)
      super(csv_row, data_import)
      @date = parse_date(value_for('date'), '%Y-%m-%d')
    end

    def create
      increment_data
      update_followers if last_day_of_month?
    end

    private

    def increment_data
      %w[streams listeners].each do |field|
        monthly_streaming.increment!(field, value_for(field).to_i)
      end
    end

    def update_followers
      @monthly_streaming.update(followers: value_for('followers').to_i)
    end

    def last_day_of_month?
      @date == @date.end_of_month
    end

    def monthly_streaming
      @monthly_streaming = ::MonthlyStreaming.find_or_create_by(
        month: @date.month,
        year: @date.year,
        month_streaming_import_id: @data_import.id
      )
    end
  end
end
