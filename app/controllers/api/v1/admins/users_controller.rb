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
          service = ::Admin::ManageUserService.call(user_id: params[:id])

          if service.success?
            render json: ::Users::UserPresenter.json_collection(service.user), status: :ok
          else
            render json: { errors: service.error }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
