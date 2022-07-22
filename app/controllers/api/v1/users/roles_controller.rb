# frozen_string_literal: true

module Api
  module V1
    module Users
      # Update roles endpoint
      class RolesController < ApiController
        def update
          role_service = RoleService.new(user_params)

          if role_service.update_role
            render json: { message: "Role updated" }, status: :ok
          else
            render json: { errors: role_service.error }, status: :bad_request
          end
        end

        private

        def user_params
          params.require(:role).permit(:email, :group_name)
        end
      end
    end
  end
end
