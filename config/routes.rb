# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/"
  mount Rswag::Api::Engine => "/"

  get "/build-info", format: :json, to: "info#build_info"
  namespace :api do
    namespace :v1 do
      namespace :admins do
        resource :registrations, only: :create
        resource :roles, only: :update
        resources :users, only: %i[index update]
        match "collaborator", to: "invites#collaborator", via: :post
        match "client", to: "invites#collaborator", via: :post
      end

      scope module: :users do
        resource :passwords, only: %i[create update]
        scope "/:role" do
          resource :sessions, only: %i[create destroy]
        end
        resource :forgot_passwords, only: :create
        resource :recover_passwords, only: :create
      end
    end
  end
end
