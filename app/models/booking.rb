class Booking < ActiveRecord::Base
  belongs_to :timeslot
  validates_presence_of :size, :timeslot_id
  validate :is_there_a_boat_with_enough_capacity, :is_there_availability_remaining
  after_save :update_customer_count, :update_availability, :check_for_overlapping_timeslot

  def update_availability
    self.timeslot.update_attributes(availability: determine_availability(self))
  end

  def determine_availability(booking)
    if (booking.timeslot.availability - booking.size) > (booking.timeslot.boats.minimum(:capacity)) || booking.timeslot.boats.length ==1
      booking.timeslot.availability - booking.size
    else
      booking.timeslot.boats.minimum(:capacity) 
    end
  end

  def update_customer_count
    self.timeslot.update_attributes(customer_count: (self.timeslot.customer_count += self.size))
  end

  def is_there_a_boat_with_enough_capacity
    if self.size > self.timeslot.boats.maximum(:capacity)
      errors.add('party is too large for the available boats')
    end
  end

  def is_there_availability_remaining
    if self.timeslot.availability < self.size
      errors.add('there is no longer enough availability remaining')
    end
  end

  def check_for_overlapping_timeslot
    overlaps = Timeslot.where({start_time: (self.timeslot.start_time.at_beginning_of_day..self.timeslot.start_time.at_end_of_day)}).where.not(id: self.timeslot.id)
    overlaps.each do |overlap| 
      if overlap.boats == self.timeslot.boats
        overlap.update_attributes(availability: 0)
      end
    end
    # figure out which boat id is the one whose availability has been altered by the booking
    # if they have overlapping timeslots and the same boat id
    # reduce the other timeslots availability by the boat capacity.
    # overlaps.each do |overlap|
    #   if boat.id = self.timeslot.boats.order(:capacity).last.id && self.id != overlap.id
    #     end_time = self.timeslot.start_time + (self.timeslot.duration * 60)
    #     if self.timeslot.start_time < overlap.start_time && end_time > overlap.start_time
    #       overlap.update_attributes(availability: 0)
    #     end
    #   end
    # end
  end
end