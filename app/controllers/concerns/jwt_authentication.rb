# frozen_string_literal: true

require 'json_web_token'

module JwtAuthentication
  def authenticate_user
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
end
