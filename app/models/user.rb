class User < ActiveRecord::Base
  include Clearance::User
  attr_accessible :email, :zipcode, :city, :state, :country, :first_name, :last_name, :sex, :password

  validates :password, :presence => true, :length => { :within => 6..40 }
  validates :email, presence: true, 
	                uniqueness: true,
	                format: {
	                      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	                }

	# Methods!

	def full_name
		return if first_name == nil || last_name == nil
		first_name + last_name
	end

end
