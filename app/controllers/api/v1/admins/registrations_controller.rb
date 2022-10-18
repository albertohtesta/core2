# frozen_string_literal: true

module Api
  module V1
    module Admins
      # users invitation and creation
      class RegistrationsController < ApiAdminController
        def create
          service = ::ValidateUserBeforeRegisterService.call(registration_params)

          if service.success?
            render json: { message: "Invitation sent successfully" }, status: :ok
          else
            render json: { error: service.error }, status: :bad_request
          end
        end

        private

        def registration_params
          params.require(:registration).permit(:email, :role)
        end
      end
    end
  end
end
