class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.datetime :start_time
      t.integer :duration
      t.integer :customer_count
      t.integer :availability
      t.string :boats, array: true
    end
  end
end
