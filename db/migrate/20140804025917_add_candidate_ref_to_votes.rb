class AddCandidateRefToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :candidate, index: true
  end
end
