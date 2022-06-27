# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for forgot password
      class ForgotPasswordsController < ApplicationController
        def create
          @recover_password_service = RecoverPasswordService.new(forgot_password_params)

          if @recover_password_service.forgot_password
            render json: { status: :ok, code: 200, message: "Recover password email sended" }
          else
            render json: { status: :bad_request, code: 400, message: @recover_password_service.error }
          end
        end

        private

        def forgot_password_params
          params.require(:credentials).permit(:username)
        end
      end
    end
  end
end
