class Booking < ActiveRecord::Base
  belongs_to :timeslot
  validates_presence_of :size, :timeslot_id
  validates_with #make sure there is room on a single boat
  before_save do
    #reduce timeslot availabilirt
  end
end