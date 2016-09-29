class ReservationsController < ApplicationController

  before_action :authorize, :except => [:index, :show]

  def index

  end

  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new

  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = current_user.reservations.new(reservation_params)
    @reservation.listing_id = @listing.id

    # @payment= @listing.payment
    #
    # @total_nights = (params[:reservation][:end_date].to_date - params[:reservation][:start_date].to_date).to_i
    # @payment= @payment * @total_nights

      if @reservation.save
        # Sends email to user when user is created.
        ReservationJob.perform_later(current_user)
        #flash notice
        flash[:notice] = "Reservation was successfully made"
        redirect_to listing_reservation_path(@listing,@reservation)
      else
        flash[:notice] = "Oops something went wrong please try again later"
        render template: "reservations/new"
      end
  end
  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :listing_id)
  end
end
