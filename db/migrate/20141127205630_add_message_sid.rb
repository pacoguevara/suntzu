class AddMessageSid < ActiveRecord::Migration
  def change
    add_column :user_messages, :message_sid, :integer
  end
end
