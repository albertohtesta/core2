# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/build-info", format: :json, to: "info#build_info"
  namespace :api do
    namespace :v1 do
      scope module: :users do
        resource :registrations, only: :create
        resource :passwords, only: %i[create update]
        resource :forgot_passwords, only: :create
        resource :recover_passwords, only: :create
        resource :sessions, only: %i[create destroy]
        resource :roles, only: :update
        resources :users, only: %i[index update]
      end
    end
  end
end
