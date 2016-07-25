Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  devise_for :accounts, :controllers => { :omniauth_callbacks => "callbacks" }
  get 'partners', to: 'partners#index'
  get 'partners/new', to: 'partners#new'
  post 'partners', to: 'partners#create'
  post 'registration', to: 'registration#create'
  get 'registration/show', to: 'registration#show'
  get 'registration/:partner_id', to: 'registration#new'
  root 'welcome#index'
end
