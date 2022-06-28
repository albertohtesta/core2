# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for forgot password
      class ForgotPasswordsController < ApplicationController
        def create
          @password_service = PasswordService.new(recover_password_params)

          if @password_service.recover_password
            render json: { status: :ok, code: 200, message: "Password recovery email sent" }
          else
            render json: { status: :bad_request, code: 400, message: @password_service.error }
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
