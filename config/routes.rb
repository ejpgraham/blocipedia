Rails.application.routes.draw do
  root to: "home#index"
  resources :wikis
  resources :charges, only: [:new, :create]
  patch "/downgrade", to: "downgrade#downgrade", as: "downgrade"

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

end
