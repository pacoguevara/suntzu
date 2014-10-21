class AddKeyToCity < ActiveRecord::Migration
  def change
    add_column :cities, :key, :string
  end
end
