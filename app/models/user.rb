class User < ActiveRecord::Base
  include Clearance::User
   mount_uploader :image, ImageUploader
   has_many :authentications, :dependent => :destroy
   has_many :listings
   has_many :reservations
  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.remote_image_url = auth_hash["extra"]["raw_info"]["picture"]["data"].url
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.encrypted_password = ('A'..'z').to_a.sample(8).join(",")
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
