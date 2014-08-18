class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.datetime :start_time
      t.integer :duration
      t.integer :availability, null: false, default: 0
      t.integer :customer_count, null: false, default: 0
    end
  end
end
