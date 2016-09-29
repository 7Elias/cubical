class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
      ReservationMailer.reservation_email(current_user).deliver_now
  end
end
