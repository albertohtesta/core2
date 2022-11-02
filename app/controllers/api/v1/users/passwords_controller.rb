# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for update password for new user
      class PasswordsController < ApiController
        skip_before_action :verify_token, :current_user, only: :create

        def create
          service = SetPasswordService.call(session_params)

          if service.success?
            render json: { message: "Password updated" }, status: :ok
          else
            render json: { errors: service.error }, status: :bad_request
          end
        end

        def update
          @password_service = PasswordService.new(session_params.merge(access_token: @access_token))

          if @password_service.update_password
            render json: { message: "Password set successfully. A confirmation mail was sent." }, status: :ok
          else
            render json: { errors: @password_service.error }, status: :bad_request
          end
        end

        private

        def session_params
          params.require(:credentials).permit(:username, :password, :new_password)
        end
      end
    end
  end
end
