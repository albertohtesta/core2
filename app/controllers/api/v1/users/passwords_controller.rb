# frozen_string_literal: true

module Api
  module V1
    module Users
      # Endpoint for update password for new user
      class PasswordsController < ApplicationController
        def create
          @session = SessionService.new(session_params).authenticate
          @challenge_service = ChallengeService.new(session_params.merge(session: @session.session,
                                                                         challenge_name: @session.challenge_name))

          if @challenge_service.respond_to_auth_challenge
            render json: { status: :ok, code: 200, message: "Password updated" }
          else
            render json: { status: :bad_request, code: 400, message: @challenge_service.error }
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
