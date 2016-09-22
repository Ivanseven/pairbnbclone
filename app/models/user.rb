class User < ActiveRecord::Base
  include Clearance::User
   has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.image = auth_hash["extra"]["raw_info"]["picture"]["data"].url
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
