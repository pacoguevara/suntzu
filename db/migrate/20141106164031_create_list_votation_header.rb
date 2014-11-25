class CreateListVotationHeader < ActiveRecord::Migration
  def change
    create_table :list_votation_headers do |t|
      t.integer :polling_id
    end
    add_index :list_votation_headers, :polling_id
  end
end
