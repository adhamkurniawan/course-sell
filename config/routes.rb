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
  end

  get 'my-courses', to: 'courses#my_courses'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
