class ReservationsController < ApplicationController
	def create
		start_date = Date.parse(params[:reservation][:start_date])
		end_date = Date.parse(params[:reservation][:end_date])
		if start_date <= end_date
			if start_date >= Date.today
				book_range = start_date..end_date
				reserve = Reservation.where(listing_id:params[:reservation][:listing_id])
				valid = true
				reservation_range = []
				reserve.each do |reservation|
					reservation_range << (Date.parse(reservation.start_date)..Date.parse(reservation.end_date))
				end
				reservation_range.each do |date|
					if date.overlaps?book_range
						valid = false
					end
				end
				if valid == true
				@reservation = current_user.reservations.create(reservation_params)
				# Send a email to host / guest
				listed = @reservation.listing
				host = listed.user
				ReservationJob.perform_later host, listed, current_user

				redirect_to root_path
				else
					session[:reservation_book_error] = "Sorry! Those dates have already been booked or reserved!" 
					redirect_to :back
				end
			else
				session[:reservation_book_error] = "Too late! Time Travel not possible." 
				redirect_to :back
			end
		else
			session[:reservation_book_error] = "End date is earlier than start date! Don't time travel!" 
			redirect_to :back
		end
	end
	def index
		@reservations = current_user.reservations
	end
	def show
		@reservation = current_user.reservations.find(params[:id])
	end

	def destroy
		@reservation = Reservation.where(params[:id])
		@reservation.destroy
		redirect_to reservation_path
	end

	def edit
		@reservation = Reservation.where(params[:id])
	end
	def update
		@reservation = Reservation.where(params[:id])
		@reservation.update(reservation_params)
		redirect_to reservation_path(params[:id])
	end
	private
	def reservation_params
		# if method != "edit"
		params.require(:reservation).permit(:start_date, :end_date, :capacity, :listing_id)
		# else
		# params.require(:reservation).permit(:start_date, :end_date, :capacity)
		# end
	end
end
