class AddFbToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb, :text
  end
end
