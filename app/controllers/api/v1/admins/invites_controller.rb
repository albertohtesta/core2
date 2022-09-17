# frozen_string_literal: true

module Api
  module V1
    module Admins
      # users invitation and creation
      class InvitesController < ApiAdminController
        ROLE_COLLAB = { groups_names: ["collaborator"] }
        ROLE_CLIENT = { groups_names: ["client"] }

        def collaborator
          service = ::ValidateUserBeforeRegisterService.for(invite_params.merge(ROLE_COLLAB))

          if service
            render json: { message: "Invitation sent successfully" }, status: :ok
          else
            render json: { error: service.error }, status: :bad_request
          end
        end

        def client
          service = ::ValidateUserBeforeRegisterService.for(invite_params.merge(ROLE_CLIENT))

          if service
            render json: { message: "Invitation sent successfully" }, status: :ok
          else
            render json: { error: service.error }, status: :bad_request
          end
        end

        private

        def invite_params
          params.require(:invites).permit(:email)
        end
      end
    end
  end
end
