class AddProfileNameToUser < ActiveRecord::Migration

  def change
    add_column :users, :profile_name, :string, null: false
  end
end
