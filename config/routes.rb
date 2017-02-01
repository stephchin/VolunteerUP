Rails.application.routes.draw do
  get 'notifications/index'
  delete 'application/:notif_id/delete_notification' => "application#delete_notification"

  get 'about' => 'landing_page#about'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    get :get_events
    get 'user_map_locations'
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
    get :get_orgevents
    post :remove_organizer
    post :remove_volunteer
  end

  root 'landing_page#index'


  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
