class AddSidMessageToUserMessage < ActiveRecord::Migration
  def change
  	add_column :user_messages, :message_sid, :string
    remove_column :messages, :message_sid
  end
end
