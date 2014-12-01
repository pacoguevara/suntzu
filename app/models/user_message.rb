class UserMessage < ActiveRecord::Base
	has_many :users
	has_many :messages

	def self.create(user_id, message_id, message_sid)
		UserMessage.connection
	    new_message = UserMessage.new
	    new_message.is_sms = true
	    new_message.user_id = user_id
	    new_message.message_id = message_id
	    new_message.message_sid = message_sid
	    new_message.save
	    new_message.id
	end
end