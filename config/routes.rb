Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:short_code', to: 'v1/urls#show'
  namespace :v1 do
    resources :urls, only: [:create]
  end

  root to: 'home#index'
end
