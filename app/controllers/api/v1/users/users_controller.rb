# frozen_string_literal: true

module Api
  module V1
    module Users
      # Users endpoint
      class UsersController < ApiController
        def index
          @users = ::Users::UserPresenter.paginate_collection(User.page(params[:page]).per(10))

          if @users
            render json: @users
          else
            render json: { errors: @users.error }, status: :bad_request
          end
        end
      end
    end
  end
end
