class AddMilitantRefToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :militant, index: true
  end
end
