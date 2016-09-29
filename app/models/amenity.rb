class Amenity < ActiveRecord::Base
  has_many :listings_amenities
  has_many :listings, through: :listing_amenity



end
