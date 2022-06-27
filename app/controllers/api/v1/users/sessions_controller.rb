# frozen_string_literal: true

module Api
  module V1
    module Users
      # users invitation and creation
      class SessionsController < ApiController
        def create
          session_service = SessionService.new(session_params)
          session = session_service.authenticate
          if session
            render json: { data: session.authentication_result },
                   status: :ok
          else
            render json: { errors: session_service.error }, status: :bad_request
          end
        end

        def destroy
          session_service = SessionService.new(params)

          if session_service.sign_out
            render json: { status: :ok, code: 200, message: "Logout" },
                   status: :ok
          else
            render json: { message: session_service.error, status: :bad_request, code: 400 }, status: :bad_request
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
