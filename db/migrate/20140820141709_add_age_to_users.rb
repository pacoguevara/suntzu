class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :city, :string
    add_column :users, :street_number, :string
    add_column :users, :neighborhood, :string
  end
end
