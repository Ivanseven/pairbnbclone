class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    byebug
  	UserMailer.reservation_email(args[0], args[1], args[2] ).deliver_later
  end
end
