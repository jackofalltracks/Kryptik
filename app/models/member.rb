class Member < ActiveRecord::Base
  attr_accessible :band_id, :user_id, :position, :bands_attributes

  belongs_to :user, dependent: :destroy 
  belongs_to :band, dependent: :destroy 

end
