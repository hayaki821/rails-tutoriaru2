Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'

    # APIコントローラへのルーティング
    namespace :api, {format: 'json'} do
      namespace :v1 do
        resources :employees, only: [:index, :show, :create, :update, :destroy]
      end
    end
  
  get '/*path', to: 'home#index' 
end
