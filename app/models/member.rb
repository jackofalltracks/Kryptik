class Member < ActiveRecord::Base
	attr_accessible :band_id, :user_id, :position, :bands_attributes, :add_others

 	belongs_to :user
	belongs_to :band

	def find_all_users_email
		User.all.each do |user|
	  		return user.email # returns an Array
		end
	end

end
