class AddMunicipalityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :municipality_id, :string
    add_index :users, :municipality_id
  end
end
