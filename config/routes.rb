Rails.application.routes.draw do
  resources :companies
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
end
