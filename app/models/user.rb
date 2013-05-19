class User < ActiveRecord::Base
  include Clearance::User
  attr_accessible :email

  validates :password, :presence => true, :length => { :within => 6..40 }
  validates :email, presence: true, 
	                uniqueness: true,
	                format: {
	                      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	                }

end
