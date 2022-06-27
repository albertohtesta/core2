# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for confirm code and recover password
      class RecoverPasswordsController < ApplicationController
        def create
          @recover_password_service = RecoverPasswordService.new(recover_password_params)

          if @recover_password_service.recover_password
            render json: { status: :ok, code: 200, message: "Password recovered" }
          else
            render json: { status: :bad_request, code: 400, message: @recover_password_service.error }
          end
        end

        private

        def recover_password_params
          params.require(:credentials).permit(:username, :password, :confirmation_code)
        end
      end
    end
  end
end
