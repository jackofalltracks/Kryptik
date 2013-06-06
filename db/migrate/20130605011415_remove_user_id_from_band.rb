class RemoveUserIdFromBand < ActiveRecord::Migration
  def change
  	remove_column :bands, :user_id 
  end
end
