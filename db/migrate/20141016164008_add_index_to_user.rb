class AddIndexToUser < ActiveRecord::Migration
  def change
  	add_index :users, :ife_key, :unique => true
  end
end
