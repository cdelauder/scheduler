class Booking < ActiveRecord::Base
  belongs_to :timeslot
  validates_presence_of :size, :timeslot_id
  validate :is_there_a_boat_with_enough_capacity
  before_save do
    self.timeslot.update_attributes(availability: (self.timeslot.availability -= self.size),
                                    customer_count: (self.timeslot.customer_count += self.size))
  end

  def is_there_a_boat_with_enough_capacity
    if self.size > self.timeslot.boats.maximum(:capacity)
      errors.add('party is too large for the available boats')
    end
  end
end