# frozen_string_literal: true

module Api
  module V1
    module Users
      # users invitation and creation
      class SessionsController < ApiController
        before_action :validate_route_role
        skip_before_action :verify_token, :current_user, only: :create

        def create
          session_service = SessionService.new(session_params, params[:role])
          session = session_service.authenticate

          if session
            render json: { data: session.authentication_result }, status: :ok
          else
            render json: { errors: session_service.error }, status: :bad_request
          end
        end

        def destroy
          session_service = SessionService.new({ access_token: @access_token }, params[:role])

          if session_service.sign_out
            render json: { message: "Logout" }, status: :ok
          else
            render json: { errors: session_service.error }, status: :bad_request
          end
        end

        private

        def validate_route_role
          render json: { message: "Invalid route" }, status: :not_found unless User::ROLES.include?(params[:role])
        end

        def session_params
          params.require(:session).permit(:username, :password)
        end
      end
    end
  end
end
