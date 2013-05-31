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

  has_many :bands

  # after_create :new_band		                

	# Methods!

	def full_name
		return if first_name == nil || last_name == nil
		first_name + last_name
	end

	def new_band
		
	end

end
