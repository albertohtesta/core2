# frozen_string_literal: true

module Api
  module V1
    module Users
      # users invitation and creation
      class RegistrationsController < ApplicationController
        def create
          @registration_service = RegistrationService.new(registration_params)

          if @registration_service.create_user
            render json: { status: :ok, code: 200, message: "Invitation sent" }
          else
            render json: { status: :bad_request, code: 400, message: @registration_service.error }
          end
        end

        private

        def registration_params
          params.require(:registration).permit(:name, :email, :group_name)
        end
      end
    end
  end
end
