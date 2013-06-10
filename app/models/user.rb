class User < ActiveRecord::Base
  rolify
  include Clearance::User
  attr_accessible :email, :zipcode, :city, :state, :country, :first_name, :last_name, :sex, :password, :role_ids

  validates :password, presence: true, length: { :within => 6..40 }
  validates :email, presence: true, 
	                uniqueness: true,
	                format: {
	                      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	                }

  has_many :members
  has_many :bands, through: :members
  # has_many :bands, dependent: :destroy 
  # has_many :members, through: :bands
  
	# Methods!

	def full_name
		return if first_name == nil || last_name == nil
		first_name + last_name
	end

  # Return false if not a member, returns band.name if true. Not case sensitive
	def member_of?(band_name)
  	self.bands.each do |band| 
			if band_name.downcase.strip === band.name.downcase.strip
				return band.name # should this just return True instead?
			else
				return false	
			end
		end 
  end


  def add_others(band_name, *args)
    @the_band = Band.find_by_name(band_name.to_s)
      args.each do |arg|
        arg = User.find_by_email(arg)
        arg.bands << @the_band
        puts arg.bands.count
      end
  end

 

end







