class Boat < ActiveRecord::Base
  has_many :timeslot, through: :assignments
  has_many :assignments
  has_many :bookings, through: :assignments
  validates_presence_of :name, :capacity
end