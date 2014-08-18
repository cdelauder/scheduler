class Booking < ActiveRecord::Base
  belongs_to :timeslot
  validates_presence_of :size, :timeslot_id
  validate :is_there_a_boat_with_enough_capacity, :is_there_availability_remaining
  after_save :update_customer_count, :update_availability

  def update_availability
    self.timeslot.update_attributes(availability: determine_availability(self))
  end

  def determine_availability(booking)
    if (booking.timeslot.availability - booking.size) > (booking.timeslot.boats.maximum(:capacity) - booking.size)
      booking.timeslot.availability - booking.size
    else
      booking.timeslot.boats.maximum(:capacity) - booking.size
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
end