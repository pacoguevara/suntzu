class AddRnmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rnm, :integer
  end
end
