class CreateListVotation < ActiveRecord::Migration
  def change
    create_table :list_votations do |t|
      t.integer :list_votation_header_id
      t.integer :user_id
      t.integer :number
      t.boolean :check
    end
    add_index :list_votations, :list_votation_header_id
    add_index :list_votations, :user_id
  end
end
