class Listing < ActiveRecord::Base
	mount_uploaders :images, ImageUploader
	has_many :listing_amenities
	has_many :amenities, through: :listing_amenities
	belongs_to :user
end
