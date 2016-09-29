class AmenitiesController < ApplicationController
	def create
		@amenity = Amenity.create(amenity_params)
		redirect_to :back
	end
	def amenity_params
		params.require(:amenity).permit(:name)
	end
end
