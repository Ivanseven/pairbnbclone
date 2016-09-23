class ListingsController < ApplicationController
	before_action :set_listing , only: [:show, :edit, :update, :add_images]

	def index
		
	end

	def show
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
	end

	def update
		@listing.update(listing_params)
		old_listing = @listing
		if params[:listing][:remove_images] == "1"
			puts "removed"
			remove_images
		end

		if params[:listing][:images]
			puts "Added"
			add_images(old_listing)
		end

		redirect_to listing_path(params[:id])
	end

	def remove_images
		@listing.remove_images!
		@listing.save
	end

	def add_images(old_listing)
		images = []
		if old_listing.images
		old_listing.images.each {|image| images << image}
		end
		params[:listing][:images].each { |image| images << image}
		@listing.update(images: images)
	end

	def destroy
		@listing.destroy
		redirect_to root_path
	end

	def set_listing
		@listing = Listing.find(params[:id])

	end 
end
