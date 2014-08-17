class Timeslot < ActiveRecord::Base
  has_many :assignments
  has_many :boats, through: :assignments
  has_many :bookings
  validates_presence_of :start_time, :duration
end