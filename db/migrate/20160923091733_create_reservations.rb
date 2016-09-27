class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
    t.integer :user_id, :listing_id, :capacity
    t.string :start_date, :end_date
    t.timestamps
    end
  end
end
