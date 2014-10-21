class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities, { :id => false} do |t|
      t.string :id, null: false
      t.string :name
      t.timestamps
    end
    add_index :municipalities, :id, :unique => true
  end
end
