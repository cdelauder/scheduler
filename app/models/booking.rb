class Booking < ActiveRecord::Base
  belongs_to :timeslot
  belongs_to :boat, through: :timeslot
  validates_presence_of :size, :boat_id
end