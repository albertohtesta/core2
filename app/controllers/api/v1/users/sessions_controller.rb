# frozen_string_literal: true

module Api
  module V1
    module Users
      # users invitation and creation
      class SessionsController < ApiController
        skip_before_action :verify_token, :current_user, only: :create

        def create
          session_service = SessionService.new(session_params, params[:role])
          session_auth = session_service.authenticate

          if session_auth
            render json: { data: session_auth }, status: :ok
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

        def session_params
          params.require(:session).permit(:username, :password)
        end
      end
    end
  end
end
