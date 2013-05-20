class Band < ActiveRecord::Base
  attr_accessible :name
  # validates_presence_of :name

  # has_many :members
  # has_many :users, :through => :members
end
