class Member < ActiveRecord::Base
	attr_accessible :band_id, :user_id, :position, :bands_attributes

 	belongs_to :user
	belongs_to :band

	def find_all_users_email
		User.all.each do |user|
	  	p user.email # returns an Array
		end
	end

end
