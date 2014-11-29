class Message < ActiveRecord::Base
  belongs_to :user_message

	def self.send_sms(to, message)
		twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
    twilio_token = "6e26775044f3087e7d9f44f003db29ae"
    twilio_phone_number = "+18027339326"
    number_to_send_to = "+528341444418"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    response = @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => "+52"+to,
      :body => message
    )
    puts response.status
    puts response.sid
    mid = save_message(message, 2)
	end

  private
  def self.save_message(message, user_id)
    Message.connection
    new_message = Message.new
    new_message.message = message
    new_message.user_id = user_id
    new_message.save
    new_message.id
  end 
 

end
