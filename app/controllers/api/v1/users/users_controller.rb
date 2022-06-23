# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for update password for new user
      class UsersController < ApplicationController
        def index
          @users = UserPresenter.paginate_collection(User.page(params[:page]).per(10))

          if @users
            render json: @users
          else
            render json: { status: :bad_request, code: 400, message: @users.error }
          end
        end
      end
    end
  end
end
