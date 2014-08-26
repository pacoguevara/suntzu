class FixUserColumn < ActiveRecord::Migration
  def change
  	rename_column :votes, :militant_id, :user_id
  end
end
