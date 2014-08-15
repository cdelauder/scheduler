class ApiController < ApplicationController

  def timeslot
    new_timeslot = Timeslot.new(api_params)
    if new_timeslot.create
      status 200
    else
      status 500
    end
  end

  private
  def api_params
    params.permit(:start_time, :duration)
  end
end
