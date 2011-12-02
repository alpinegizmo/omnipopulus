Rails.application.routes.draw do
  match '/login'                  => 'omnipopulus/auth#new',      :as => :login
  match '/add_credentials'        => 'omnipopulus/auth#add',      :as => :add_credentials
  match '/auth/:service/callback' => 'omnipopulus/auth#callback'
  match '/auth/failure'           => 'omnipopulus/auth#failure'
  match '/logout'                 => 'omnipopulus/auth#destroy',  :as => :logout
end
