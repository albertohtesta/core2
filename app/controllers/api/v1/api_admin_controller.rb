# frozen_string_literal: true

module Api
  module V1
    # api admin v1 controller
    class ApiAdminController < ApiController
      before_action :authorize_user

      def authorize_user
        render json: { message: "You are not authorized to perform this action" }, status: :unauthorized unless current_user.admin?
      end
    end
  end
end
