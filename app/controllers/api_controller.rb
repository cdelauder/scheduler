require 'date'
class ApiController < ApplicationController 

  def timeslots
    date = Date.parse(get_timeslot_params[:date])
    render json: Timeslot.where(start_time: (date.at_beginning_of_day..date.at_end_of_day)).to_json  
  end

  def new_timeslots
    new_timeslot = Timeslot.new(start_time: Time.at(timeslot_params[:start_time].to_i).to_datetime, 
      duration: timeslot_params[:duration])
    if new_timeslot.save
      render json: new_timeslot.to_json
    else
      head :bad_request
    end
  end


  def new_boats
    new_boat = Boat.new(boat_params)
    if new_boat.save
      render json: new_boat.to_json
    else
      head :bad_request
    end
  end

  def boats
    render json: Boat.all.to_json
  end

  def assignment
    new_assignment = Assignment.new(Boat.find(assignment_params[:boat_id]), 
                                    Timeslot.find(assignment_params[:timeslot_id]))
    if new_assignment.save
      render json: new_assignment.to_json
    else
      head :bad_request
    end
  end

  def booking
    #create booking if conditions are met
    #return booking in JSON
  end

  private
  def timeslot_params
    params.fetch(:timeslot, {}).permit(:start_time, :duration)
  end

  def get_timeslot_params
    params.permit(:date)
  end

  def boat_params
    params.fetch(:boat, {}).permit(:name, :capacity)
  end

  def assignment_params
    params.fetch(:assignment, {}).permit(:timeslot_id, :boat_id)
  end
end
