Rails.application.routes.draw do
  get 'about' => 'landing_page#about'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    # delete :remove_event
    get :get_events
    get 'user_map_location'
    get :user_map_locations, on: :collection
  end
  resources :events do
    post :add_user
    delete :remove_event
    get 'map_location'
    get :map_locations, on: :collection
  end
  resources :organizations do
    post :add_user
    get :dashboard, on: :collection
    post :remove_organizer
    post :remove_volunteer
  end

  root 'landing_page#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
