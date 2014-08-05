class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.boolean :is_sms
      t.boolean :is_mail
    end
  end
end
