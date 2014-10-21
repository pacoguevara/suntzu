class AddTempCheckToUser < ActiveRecord::Migration
  def change
    add_column :users, :temp_chek, :boolean
  end
end
