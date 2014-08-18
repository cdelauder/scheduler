class Assignment < ActiveRecord::Base
  belongs_to :boat
  belongs_to :timeslot
  validates_presence_of :boat_id, :timeslot_id
  before_save :update_availability

  def update_availability
    # only update the availability if the newly assigned boat has a larger capacity than the current availability
    if self.timeslot.availability < self.boat.capacity
      self.timeslot.update_attributes(availability: self.boat.capacity)
    end
  end
end