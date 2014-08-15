class AddSectorToUser < ActiveRecord::Migration
  def change
    add_column :users, :sector, :string
  end
end
