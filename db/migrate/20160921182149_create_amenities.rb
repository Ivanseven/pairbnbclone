class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
    	t.string :name, :description, :category
    end
  end
end
