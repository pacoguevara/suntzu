class AddCoordinadorIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :coordinador_id, :integer
  end
end
