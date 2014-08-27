class AddIfeKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ife_key, :string
  end
end
