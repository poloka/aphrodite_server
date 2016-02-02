require 'omniauth-facebook'

class User < ActiveRecord::Base
	# attr_accessor :provider, :uid, :name, :oauth_token, :oauth_expires_at

	def self.from_omniauth(auth)
		
		@user = User.find_by uid: auth.uid
		return @user if @user

		@user = User.new
		@user.provider = auth.provider
		@user.uid = auth.uid
		@user.name = auth.info.name
		@user.oauth_token = auth.credentials.token
		@user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		@user.save!

		@user
  	# where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
   #  	user.provider = auth.provider
   #  	user.uid = auth.uid
   #  	user.name = auth.info.name
   #  	user.oauth_token = auth.credentials.token
   #  	user.oauth_expires_at = Time.at(auth.credentials.expires_at)
   #  	user.save!
  	# end
	end  

	# def self.from_omniauth(auth)

	# end

	def create
    @user = User.new(user_params)
    @user.save!
  end

  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at)
  end
end
