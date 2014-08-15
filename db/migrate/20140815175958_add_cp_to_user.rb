class AddCpToUser < ActiveRecord::Migration
  def change
    add_column :users, :cp, :string
  end
end
