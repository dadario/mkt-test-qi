# frozen_string_literal: true

Rails.application.routes.draw do
  resources :questions
  resources :services do
    collection do
      post :requested
    end
    member do
      get :execute
      get :result
    end
  end
  resources :answers, only: :create

  get '/finished', to: 'process#finished'
  get '/:external_code', to: 'process#index'
end
