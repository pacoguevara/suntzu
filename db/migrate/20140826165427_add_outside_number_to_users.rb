class AddOutsideNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :outside_number, :integer
  end
end
