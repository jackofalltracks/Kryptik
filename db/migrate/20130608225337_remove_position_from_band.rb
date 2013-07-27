class RemovePositionFromBand < ActiveRecord::Migration
  def change
  	remove_column :bands, :position 
  	add_column :members, :position, :string
  end
end
