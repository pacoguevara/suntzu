class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :candidate_id

      t.timestamps
    end
    add_index :groups, :candidate_id
  end
end
