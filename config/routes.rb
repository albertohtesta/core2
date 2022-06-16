# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/build_info", to: "info#build_info"
  namespace :api do
    namespace :v1 do
      scope module: :users do
        resource :registrations, only: :create
      end
    end
  end
end
