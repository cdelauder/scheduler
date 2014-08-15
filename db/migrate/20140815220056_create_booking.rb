class CreateBooking < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :timeslot
      t.integer :size
    end
  end
end
