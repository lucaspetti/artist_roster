# frozen_string_literal: true

module Api
  module V1
    class PlaylistDataImportsController < ActionController::API
      include JwtAuthentication

      before_action :authenticate_user

      def create
        file = playlist_data_import_params.delete(:file)
        playlist_data_import = PlaylistDataImport.new(playlist_data_import_params)
        playlist_data_import.user_id = @user.id

        playlist_data_import.file.attach(
          io: File.open(file.tempfile),
          filename: file.original_filename
        )
        playlist_data_import.save!

        head :no_content
      rescue ActiveRecord::RecordInvalid => e
        render json: { code: 'record_invalid', message: e.message }, status: 422
      end

      private

      def playlist_data_import_params
        params.permit(:artist_id, :month, :year, :file)
      end
    end
  end
end
