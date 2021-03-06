class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :message
      t.string :deep

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
