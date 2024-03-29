class Band < ActiveRecord::Base
  attr_accessible :name, :genre, :bio, :members_attributes
  validates_presence_of :name

  has_many :members 
  has_many :members, dependent: :destroy 
  has_many :users, through: :members
  accepts_nested_attributes_for :members

  # Class Method returns all Bands positions
  def self.positions
  	Band.all.each do |e| 
  		puts e.position
  	end 
  end

  def members_statuses
    self.users.each do |u|
      u.statuses.each { |s| p s.content }
    end
  end

  
end
