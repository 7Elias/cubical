class User < ActiveRecord::Base
  include Clearance::User
# authentications for facebook
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent=> :destroy
  has_many :reservations
# validation for others log in
  validates :email, :uniqueness=>true ,format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password ,presence: true


#User AvatarUploader
  mount_uploader :avatar, AvatarUploader

# method from OmniAuth for facebook
  def self.create_with_auth_and_hash(authentication,auth_hash)
  create! do |u|
      u.name = auth_hash["extra"]["raw_info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.remote_avatar_url = auth_hash["info"]["image"].gsub('http://','https://')
      u.password = SecureRandom.hex(6)
      u.remember_token = SecureRandom.hex(4)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
end
