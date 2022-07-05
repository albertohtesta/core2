# frozen_string_literal: true

module Api
  module V1
    # api v1 controller
    class ApiController < ApplicationController
      before_action :access_token

      def access_token
        @access_token ||= request.headers["Authorization"]
      end

      def verify_token
        TokenService.new({ token: @access_token }).verify
      end
    end
  end
end
