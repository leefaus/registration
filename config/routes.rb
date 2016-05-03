Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  devise_for :accounts, :controllers => { :omniauth_callbacks => "callbacks" }

  post 'registration', to: 'registration#create'
  get 'registration/:partner_id', to: 'registration#new'
  root 'welcome#index'
end
