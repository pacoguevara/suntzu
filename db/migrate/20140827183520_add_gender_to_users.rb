class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :candidates, :gender, :string
  end
end
