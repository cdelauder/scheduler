class Booking < ActiveRecord::Base
  belongs_to :timeslot
  validates_presence_of :size, :timeslot_id
  validate :is_there_a_boat_with_enough_capacity, :is_there_availability_remaining
  after_save :update_customer_count, :update_availability, :check_for_overlapping_timeslot

  def update_availability
    # new booking will reduce availability by some amount
    self.timeslot.update_attributes(availability: determine_availability(self))
  end

  def determine_availability(booking)
    # if there is only 1 boat in this timeslot availability goes down by the size of the booking
    # if there is more than one availibility is whichever is greater between the availibility - size OR capacity of other boat
    if (booking.timeslot.availability - booking.size) > (booking.timeslot.boats.minimum(:capacity)) || booking.timeslot.boats.length ==1
      booking.timeslot.availability - booking.size
    else
      booking.timeslot.boats.minimum(:capacity) 
    end
  end

  def update_customer_count
    # increase the customer count by the booking size
    self.timeslot.update_attributes(customer_count: (self.timeslot.customer_count += self.size))
  end

  def is_there_a_boat_with_enough_capacity
    # if there is not a boat big enough to hold the party the booking can't be made
    if self.size > self.timeslot.boats.maximum(:capacity)
      errors.add('party is too large for the available boats')
    end
  end

  def is_there_availability_remaining
    # There needs to be availability for that many people too
    if self.timeslot.availability < self.size
      errors.add('there is no longer enough availability remaining')
    end
  end

  def check_for_overlapping_timeslot
    # check to see if there are other timeslots that day
    # check to see if they use the same boats
    # check to see if the timeslots actually overlap
    overlaps = Timeslot.where({start_time: (self.timeslot.start_time.at_beginning_of_day..self.timeslot.start_time.at_end_of_day)}).where.not(id: self.timeslot.id)
    overlaps.each do |overlap| 
      if overlap.boats == self.timeslot.boats && overlap.boats.length < 2
        overlap.update_attributes(availability: 0)
      else
        overlap.update_attributes(availability: overlap.boats.miniumum(:capacity))
      end
    end
  end
end