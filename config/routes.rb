Guestbook::Application.routes.draw do
  resources :wall, only: [:index, :create]
  root :to => "wall#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/login" => "sessions#new", :as => :login
  match "/signout" => "sessions#destroy", :as => :signout
end
