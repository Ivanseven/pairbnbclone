class ReservationJob < ActiveJob::Base
  queue_as :default
  	# include Sidekiq::Worker
  def perform(host, listing, user)

    # Do something later
 	UserMailer.reservation_email(host, listing, user).deliver_later

  end
end
