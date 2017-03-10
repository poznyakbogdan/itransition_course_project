class User < ApplicationRecord
 	has_many :instructions, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  acts_as_voter
  
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email || User.default_email
	    user.name = auth.info.name  
	    user.image_url = auth.info.image 
	   	user.provider = auth.provider
	  end
	end


	private
	def self.default_email
		""
	end
end
