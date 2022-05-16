# frozen_string_literal: true

module Api
  module V1
    class MonthStreamingImportsController < ActionController::API
      def create; end

      def month_streaming_import_params
        params.permit(:artist_id, :month, :year, :file)
      end
    end
  end
end
