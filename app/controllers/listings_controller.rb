class ListingsController < ApplicationController


# before_action :set_listing, only: [:show, :edit, :update, :destroy]
before_action :authorize, :except => [:index, :show]
before_action :find_listing, only: [:edit, :show, :destroy, :update]
  def index
    @listings = Listing.order("created_at desc")
    render template: "home/index"
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
      if @listing.save
        flash[:notice] = "listing was successfully created"
        redirect_to listing_path(@listing)
      else
        render template: "listings/new"
      end
  end

  def edit

  end

  def show

  end

  def update
    if @listing.update(listing_params)
      redirect_to listing_path(@listing)
    else
      render template: "listings/edit"
    end

    def destroy
      @listing.destroy
      redirect_to listing_path
    end

    def set_listing
      unless current_user
        @listing = Listing.find(params[:id]) if params[:id]
      else
        @listing = current_user.listings.find(params[:id])
      end
    end
  end

  private

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
	   params.require(:listing).permit(:list_name, :property_type, :room_type, :city, :location, {:amenity_ids=>[]}, :capacity,{avatars:[]}, :price)
  end
end
