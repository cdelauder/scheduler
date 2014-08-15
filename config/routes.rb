Rails.application.routes.draw do

  resources :api, only: [] do
    collection do
      post :timeslot
      # get :timeslots
      # post :boat
      # get :boats
      # post :assignment
      # post :booking
    end
  end
end
