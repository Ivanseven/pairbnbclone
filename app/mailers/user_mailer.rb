class UserMailer < ApplicationMailer
default from: 'sir.ern@gmail.com'

	def welcome_email(user)
		@user = user
		@url = 'http://localhost:3000/'
		mail(to: @user.email, subject: 'Email Creation')
	end

	def reservation_email(host, listing, user)
		@user = user
		@host = host
		@listing = listing
		@url = 'http://localhost:3000/'
		mail(to: @host.email, subject: 'Listing Reservation')
	end
end