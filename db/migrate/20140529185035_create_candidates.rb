class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end