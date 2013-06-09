class Band < ActiveRecord::Base
  attr_accessible :name, :genre, :bio, :members_attributes
  validates_presence_of :name

  has_many :users, through: :members
  has_many :members, dependent: :destroy 
  accepts_nested_attributes_for :members

  # Class Method returns all Bands positions
  def self.positions
  	Band.all.each do |e| 
  		puts e.position
  	end 
  end

  
end
