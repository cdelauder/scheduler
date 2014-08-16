Rails.application.routes.draw do

  resources :api, only: [] do
    collection do
      post :timeslots, to: 'api#new_timeslots'  
      get :timeslots 
      post :boat
      # get :boats
      # post :assignment
      # post :booking
    end
  end
end
