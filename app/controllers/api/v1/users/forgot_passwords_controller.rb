# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for forgot password
      class ForgotPasswordsController < ApiController
        skip_before_action :verify_token

        def create
          @password_service = PasswordService.new(recover_password_params)

          if @password_service.recover_password
            render json: { message: "Password recovery email sent" }, status: :ok
          else
            render json: { message: @password_service.error }, status: :bad_request
          end
        end

        private

        def recover_password_params
          params.require(:credentials).permit(:username)
        end
      end
    end
  end
end
