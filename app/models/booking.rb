class Booking < ActiveRecord::Base
  belongs_to :boat
  validates_presence_of :size, :boat_id

end