Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :companies do
    get '/companies/:id', to: 'jobs#index'
    resources :jobs
  end
end
