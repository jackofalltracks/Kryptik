class Member < ActiveRecord::Base
	attr_accessible :band_id, :user_id, :position, :bands_attributes, :add_others

 	belongs_to :user
	belongs_to :band

	def find_all_users_email
		User.all.each do |user|
	  	return user.email # returns an Array
		end
	end

	def add_others(band, *args)
      @the_band = Band.find(params[:band_id])
      args.each do |arg|
        arg =  User.find(params[:user_id])
        arg.bands << @the_band
        # puts arg.bands.count
      end
  end

end
