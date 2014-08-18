Rails.application.routes.draw do

  resources :api, only: [] do
    collection do
      post :timeslots, to: 'api#new_timeslots'  
      get :timeslots 
      post :boats, to: 'api#new_boats'
      get :boats
      post :assignments, to: 'api#assignments'
      post :bookings, to: 'api#bookings'
    end
  end
end
