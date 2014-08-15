class AddBirdToUser < ActiveRecord::Migration
  def change
    add_column :users, :bird, :datetime
  end
end
