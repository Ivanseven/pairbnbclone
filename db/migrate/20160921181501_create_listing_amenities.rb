class CreateListingAmenities < ActiveRecord::Migration
  def change
    create_table :listing_amenities do |t|
    	t.integer :listing_id, :amenity_id
    end
  end
end
