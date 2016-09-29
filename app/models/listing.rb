class Listing < ActiveRecord::Base
  has_many :listing_amenities
  has_many :amenities, through: :listing_amenities
  has_many :reservations

  mount_uploaders :avatars, AvatarUploader

  enum room_type: {
    'Private Room': '1',
    'Shared Room': '2',
    'Entire Home/Apt': '3'
  }

  enum property_type: {
    'Condo': '1',
    'Services Apartment': '2',
    'Landed': '3'
  }

end
