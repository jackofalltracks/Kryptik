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

  has_many :bands, through: :members
  has_many :members, dependent: :destroy 

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

end
