class Boat < ActiveRecord::Base
  has_many :assignments
  has_many :bookings
  validates_presence_of :name, :capacity
end