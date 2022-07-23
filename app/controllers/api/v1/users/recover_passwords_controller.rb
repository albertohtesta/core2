# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for confirm code and recover password
      class RecoverPasswordsController < ApiController
        skip_before_action :verify_token, :current_user

        def create
          @password_service = PasswordService.new(confirm_recover_password_params)

          if @password_service.confirm_recover_password
            render json: { message: "Password recovered" }, status: :ok
          else
            render json: { message: @password_service.error }, status: :bad_request
          end
        end

        private

        def confirm_recover_password_params
          params.require(:credentials).permit(:username, :password, :confirmation_code)
        end
      end
    end
  end
end
