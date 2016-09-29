class HomeController < ApplicationController
  def index

  @listings = Listing.order('created_at DESC').page(params[:page]).per(15)
    render template: "home/index"
  end
  def new
  end



end
