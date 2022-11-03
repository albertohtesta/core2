# frozen_string_literal: true

module Api
  module V1
    module Admins
      # Update roles endpoint
      class RolesController < ApiAdminController
        def update
          service = RoleService.call(role_params)

          if service.success?
            render json: { message: "Role updated" }, status: :ok
          else
            render json: { errors: service.error }, status: :bad_request
          end
        end

        private

        def role_params
          params.require(:role).permit(:email, :old_role, :new_role)
        end
      end
    end
  end
end
