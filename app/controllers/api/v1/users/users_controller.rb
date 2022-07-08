# frozen_string_literal: true

module Api
  module V1
    module Users
      # Users endpoint
      class UsersController < ApiController
        skip_before_action :verify_token

        def index
          @users = ::Users::UserPresenter.paginate_collection(User.page(params[:page]).per(10))

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
            render json: { errors: user_service.error }, status: :bad_request
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
