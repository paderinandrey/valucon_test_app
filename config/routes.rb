Rails.application.routes.draw do
  resources :feedbacks, only: [:index, :create], defaults: { format: :json }
  resources :photos, only: [:create, :index]

  root to: 'application#index'
end
