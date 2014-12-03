class AddStatusColumn < ActiveRecord::Migration
  def change
  	add_column :user_messages, :status, :string
  end
end
