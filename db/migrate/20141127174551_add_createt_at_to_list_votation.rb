class AddCreatetAtToListVotation < ActiveRecord::Migration
  def change
    add_column :list_votations, :created_at, :datetime
    add_column :list_votations, :update_at, :datetime
  end
end
