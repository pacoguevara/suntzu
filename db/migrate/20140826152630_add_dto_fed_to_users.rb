class AddDtoFedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dto_fed, :integer
    add_column :users, :dto_loc, :integer
    add_column :users, :internal_number, :integer
  end
end
