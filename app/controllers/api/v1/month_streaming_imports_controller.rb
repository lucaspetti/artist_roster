# frozen_string_literal: true

module Api
  module V1
    class MonthStreamingImportsController < ActionController::API
      include JwtAuthentication

      before_action :authenticate_user

      def create
        file = month_streaming_import_params.delete(:file)
        month_streaming_import = MonthStreamingImport.new(month_streaming_import_params)

        month_streaming_import.file.attach(
          io: File.open(file.tempfile),
          filename: file.original_filename
        )
        month_streaming_import.save!

        head :no_content
      rescue ActiveRecord::RecordInvalid => e
        render json: { code: 'record_invalid', message: e.message }, status: 422
      end

      def month_streaming_import_params
        params.permit(:artist_id, :file)
      end
    end
  end
end
