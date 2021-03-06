Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'courses#index'

  resources :courses do
    # courses/:id/subscribe
    member do
      get :subscribe
    end
    resources :tasks, only: [:show]
    resources :reviews, only: [:create, :destroy]
  end

  get 'my-courses', to: 'courses#my_courses'
  post 'payment-notification', to: 'courses#payment_notification'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
