class Band < ActiveRecord::Base
  attr_accessible :name, :user_id, :position, :positions
  validates_presence_of :name

  belongs_to :user

  def self.positions
  	Band.all.each do |e| 
  		puts e.position
  	end 
  end

  
end
