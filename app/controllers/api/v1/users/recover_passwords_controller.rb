# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for confirm code and recover password
      class RecoverPasswordsController < ApplicationController
        def create
          @password_service = PasswordService.new(confirm_recover_password_params)

          if @password_service.confirm_recover_password
            render json: { status: :ok, code: 200, message: "Password recovered" }
          else
            render json: { status: :bad_request, code: 400, message: @password_service.error }
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
