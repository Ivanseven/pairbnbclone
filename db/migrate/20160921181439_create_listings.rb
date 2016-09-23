class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
		t.string :name, :about, :location, :bed_type, :property_type, :room_type, :check_in_time, :check_out_time, :reserved_dates
		t.integer :user_id, :price, :capacity, :bathrooms, :bedrooms, :beds, :instant_book
		t.timestamps
    end
  end
end
