class CreateCandidateVotations < ActiveRecord::Migration
  def change
	drop_table :candidate_votations
    create_table :candidate_votations do |t|
      t.integer :candidate_id
      t.integer :polling_id
	  	
      t.timestamps
    end
    add_index :candidate_votations, :candidate_id
    add_index :candidate_votations, :polling_id
  end
end