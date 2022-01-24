Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations', 
      passwords: 'users/passwords'
  }
  namespace :api do
    namespace :v1 do
      # resources :tasks, only: [:index, :create]
      resources :tasks
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
