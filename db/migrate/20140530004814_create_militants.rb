class CreateMilitants < ActiveRecord::Migration
  def change
    create_table :militants do |t|
      t.datetime :register_date
      t.string :first_name
      t.string :last_name
      t.string :name
      t.datetime :bird
      t.string :rnm
      t.string :linking
      t.string :sub_linking
      t.integer :group_id
      t.string :suburb
      t.string :section
      t.string :sector
      t.string :cp
      t.string :phone
      t.string :cellphone
      t.string :email

      t.timestamps
    end
    add_index :militants, :group_id
  end
end
