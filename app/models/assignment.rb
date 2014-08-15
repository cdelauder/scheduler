class Assignment < ActiveRecord::Base
  belongs_to :boat
  belongs_to :timeslot
  validates_presence_of :boat_id, :timeslot_id
end