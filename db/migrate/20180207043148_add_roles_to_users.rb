class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :standard, :boolean
    add_column :users, :premium, :boolean
    add_column :users, :admin, :boolean
  end
end
