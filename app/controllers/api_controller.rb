class ApiController < ApplicationController

  def timeslots
    new_timeslot = Timeslot.new(api_params)
    if new_timeslot.create
      respond_to do |format|
        format.json { render json: new_timeslot }
      end
    else
      respond_to do |format|
        format.json { render json:  {message: 'Resource not found'} }
      end
    end
  end

  def timeslots
    all_timeslots = Timeslot.all

  end

  def boat
    new_boat = Boat.new(api_params)
    if new_boat.create
      status 200
    else
      status 500
    end
  end

  private
  def api_params
    params.permit(:start_time, :duration, :name, :capacity)
  end
end
