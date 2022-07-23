# frozen_string_literal: true

module Api
  module V1
    module Users
      # users invitation and creation
      class RegistrationsController < ApiAdminController
        def create
          @registration_service = RegistrationService.new(registration_params)

          if @registration_service.create_user
            render json: { message: "Invitation sent successfully" }, status: :ok
          else
            render json: { errors: @registration_service, message: @registration_service.error }, status: :bad_request
          end
        end

        private

        def registration_params
          params.require(:registration).permit(:email, :group_name)
        end
      end
    end
  end
end
