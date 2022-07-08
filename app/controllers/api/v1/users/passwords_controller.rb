# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for update password for new user
      class PasswordsController < ApiController
        skip_before_action :verify_token, only: :create

        def create
          @challenge_service = ChallengeService.new(session_params)

          if @challenge_service.respond_to_change_password_challenge
            render json: { message: "Password updated" }, status: :ok
          else
            render json: { errors: @challenge_service.error }, status: :bad_request
          end
        end

        def update
          @password_service = PasswordService.new(session_params.merge(access_token: @access_token))

          if @password_service.update_password
            render json: { message: "Password set successfully. A confirmation mail was sent." }, status: :ok
          else
            render json: { errors: @password_service.error }, status: :bad_request
          end
        end

        private

        def session_params
          params.require(:credentials).permit(:username, :password, :new_password)
        end
      end
    end
  end
end
