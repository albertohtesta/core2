# frozen_string_literal: true

module Api
  module V1
    module Admins
      # Users endpoint
      class UsersController < ApiAdminController
        def index
          @users = ::Users::UserPresenter.paginate_collection(UserRepository.ordered_by_email.page(params[:page]).per(10))

          if @users
            render json: @users
          else
            render json: { errors: @users.error }, status: :bad_request
          end
        end

        def update
          user_service = UserService.new(user_params)

          update_user = user_params[:is_enabled] ? user_service.enable_user : user_service.disable_user

          if update_user
            render json: { message: user_params[:is_enabled] ? "User was enabled" : "User was disabled" }, status: :ok
          else
            render json: { errors: user_service.error }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :is_enabled)
        end
      end
    end
  end
end
