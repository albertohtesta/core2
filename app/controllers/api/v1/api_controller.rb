# frozen_string_literal: true

module Api
  module V1
    # api v1 controller
    class ApiController < ApplicationController
      before_action :access_token, :verify_token, :current_user

      def access_token
        @access_token ||= request.headers["Authorization"]
      end

      def verify_token
        render json: { message: "Invalid token" }, status: :unauthorized unless decoded_token
      end

      def decoded_token
        @decoded_token ||= TokenService.new({ token: access_token }).decode
      end

      def current_user
        user = UserService.new({ token: access_token })
        @current_user ||= UserRepository.find_by_email(user.logged_user_email)
      end
    end
  end
end
