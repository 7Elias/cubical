class ReservationMailer < ApplicationMailer

default from: "o.jingyao@gmail.com"

# def reservation_email (customer,host, reservation_id)
#     @user = customer
#     @url = url_for([@listing,@reservation])
#     mail(to: @user.email, subject: 'Reservation Email')
# end

  def reservation_email(user)
    @user = user
    @url ="http://"
    mail(to: @user.email, subject: 'Reservation Confirmation')
  end
end
#
