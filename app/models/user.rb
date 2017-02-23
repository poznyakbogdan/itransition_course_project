class User < ApplicationRecord
 
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email || ""
	    user.name = auth.info.name  
	    user.image_url = auth.info.image 
	   	user.provider = auth.provider
	  end
	end
end
