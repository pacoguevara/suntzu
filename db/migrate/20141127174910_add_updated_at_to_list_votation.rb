class AddUpdatedAtToListVotation < ActiveRecord::Migration
  def change
    add_column :list_votations, :updated_at, :datetime
  end
end
