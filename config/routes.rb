Rails.application.routes.draw do
  resources :feedbacks, only: [:index, :create], defaults: { format: :json }

  root to: 'application#index'
end
