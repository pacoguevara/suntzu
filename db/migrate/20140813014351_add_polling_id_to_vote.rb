class AddPollingIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :polling_id, :int
    add_index :votes, :polling_id
  end
end
