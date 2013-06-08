class Member < ActiveRecord::Base
  attr_accessible :band_id, :user_id

  belongs_to :user
  belongs_to :band, dependent: :destroy 

end
