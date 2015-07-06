Rails.application.routes.draw do
  devise_for :users
  root 'jobs#index'

  resources :jobs do
    resources :comments, :only => [:create]
  end
end
