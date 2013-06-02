class AddPositionToBand < ActiveRecord::Migration
  def change
    add_column :bands, :position, :string
  end
end
