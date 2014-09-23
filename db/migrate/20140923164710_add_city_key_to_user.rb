class AddCityKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :city_key, :int
  end
end
