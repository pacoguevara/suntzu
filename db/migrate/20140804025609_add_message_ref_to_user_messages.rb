class AddMessageRefToUserMessages < ActiveRecord::Migration
  def change
    add_reference :user_messages, :message, index: true
  end
end
