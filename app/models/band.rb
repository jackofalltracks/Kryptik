class Band < ActiveRecord::Base
  attr_accessible :name, :position, :positions, :genre, :bio #:user_id
  validates_presence_of :name

  has_many :users, through: :members
  has_many :members

  def self.positions
  	Band.all.each do |e| 
  		puts e.position
  	end 
  end

  
end
