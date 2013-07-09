class Status < ActiveRecord::Base
  attr_accessible :content, :index, :user_id
  belongs_to :user
end
