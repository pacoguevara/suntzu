class AddUserRefToUserMessages < ActiveRecord::Migration
  def change
    add_reference :user_messages, :user, index: true
  end
end
