class ChangeRnmToUser < ActiveRecord::Migration
  def change
  	change_column :users, :rnm, :string
  end
end
