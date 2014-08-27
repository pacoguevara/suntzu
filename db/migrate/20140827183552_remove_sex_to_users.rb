class RemoveSexToUsers < ActiveRecord::Migration
  def change
    remove_column :candidates, :sex, :string
  end
end
