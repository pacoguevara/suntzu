class AddEnlaceIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :enlace_id, :integer
  end
end
