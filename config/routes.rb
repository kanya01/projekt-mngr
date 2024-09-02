# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    resources :tasks
  end
  root 'projects#index'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  resources :tasks, only: [:index]

  # resources :wiki, controller: 'wiki'
  get 'wiki', to: 'wiki#main', as: :main_wiki
  resources :wiki, controller: 'wiki'

  get 'dashboard', to: 'dashboard#index', as: :dashboard

  get 'profile', to: 'profile#show'
  get 'profile/edit', to: 'profile#edit', as: :edit_profile
  patch 'profile', to: 'profile#update'
end
