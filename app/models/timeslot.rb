class Timeslot < ActiveRecord::Base
  has_many :assignments
  validates_presence_of :start_time, :duration
end