Rails.application.routes.draw do

  devise_for :users
  resources :users do
    delete :remove_event
  end
  resources :events do
    post :add_user
  end
  resources :organizations do
    post :add_user
  end

  root 'landing_page#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
