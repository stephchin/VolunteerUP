Rails.application.routes.draw do
  resources :organizations
  root 'landing_page#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
