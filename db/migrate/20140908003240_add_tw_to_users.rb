class AddTwToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tw, :text
  end
end
