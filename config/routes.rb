# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/"
  mount Rswag::Api::Engine => "/"

  get "/build-info", format: :json, to: "info#build_info"
  namespace :api do
    namespace :v1 do
      scope module: :users do
        resource :registrations, only: :create
        resource :passwords, only: %i[create update]
        resource :sessions, only: %i[create destroy]
        resource :forgot_passwords, only: :create
        resource :recover_passwords, only: :create
        resource :roles, only: :update
        resources :users, only: %i[index update]
      end
    end
  end
end
