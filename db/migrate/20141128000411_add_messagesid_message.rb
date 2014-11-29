class AddMessagesidMessage < ActiveRecord::Migration
  def change
    add_column :messages, :message_sid, :integer
    remove_column :user_messages, :message_sid
  end
end
