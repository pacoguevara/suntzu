class UserMessage < ActiveRecord::Base
	has_many :users
	has_many :messages

	def create(user_id, message_id)
		UserMessage.connection
	    new_message = UserMessage.new
	    new_message.is_sms = true
	    new_message.user_id = user_id
	    new_message.message_id = message_id
	    new_message.save
	end
end