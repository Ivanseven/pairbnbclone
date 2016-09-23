class ListingsController < ApplicationController

	def index
		
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def new
		@listing ||= Listing.new
	end

	def listing_params
		# params.require(:listing).permit(:name, :about, :location, :bed_type, :property_type, :room_type, :check_in_time, :check_out_time, :reserved_dates, :price, :capacity, :bathrooms, :bedrooms, :beds, :instant_book, {images: []})
		params.require(:listing).permit(:name, :about, :location, :bed_type, :property_type, :room_type, :check_in_time, :check_out_time, :reserved_dates, :price, :capacity, :bathrooms, :bedrooms, :beds, :instant_book)
	end

	def create
		@listing = current_user.listings.create(listing_params)
		# @listing = Listing.new(listing_params)
		# @listing.user_id = current_user.id
		if @listing.save # Saves, then checks if was saved successfully or stopped by validation
			current_user.host ||= 1
			current_user.save
			redirect_to listing_path(@listing)
		else
			# Pass current values in params/sessions?
			redirect_to new_listing_path
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params)
		if params[:listing][:remove_images]
			@listing.remove_images!
			@listing.save
		end
		if params[:listing][:images]
		add_images
		end
		redirect_to listing_path(params[:id])
	end

	def add_images
		@listing = Listing.find(params[:id])
		images = []
		if @listing.images
		@listing.images.each {|image| images << image}
		end
		params[:listing][:images].each { |image| images << image}
		@listing.update(images: images)
	end

	def destroy
		@listing
	end
end
