class AddSubenlaceIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :subenlace_id, :integer
  end
end
