# frozen_string_literal: true

require 'json_web_token'

module Api
  module V1
    class PlaylistDataImportsController < ActionController::API
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

      def authenticate_user
        # TODO: improve user authentication for api
        token = request.headers['Authorization']

        payload = JsonWebToken.decode(token)
        if payload.nil?
          render json: { message: 'unauthorized' }, status: :unauthorized
          return
        end

        @user = User.find_by(payload)

        if @user.nil?
          render json: { message: 'unauthorized' }, status: :unauthorized
        end

      end

      def playlist_data_import_params
        params.permit(:artist_id, :month, :year, :file)
      end
    end
  end
end
