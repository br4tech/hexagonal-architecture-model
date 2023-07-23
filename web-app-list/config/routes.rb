Rails.application.routes.draw do
  resources :user, only: [:index, :show]
end
