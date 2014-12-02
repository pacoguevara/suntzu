class Message < ActiveRecord::Base
  belongs_to :user_message

  def self.send_sms(to, message, user_id, message_id)
  	twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
    twilio_token = "6e26775044f3087e7d9f44f003db29ae"
    twilio_phone_number = "+18027339326"
    number_to_send_to = "+528341444418"
    #@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    #response = @twilio_client.account.sms.messages.create(
    #  :from => "#{twilio_phone_number}",
    #  :to => "+52"+to,
    #  :body => message
    #)
    #puts response.status
    #puts response.sid
    #mid = response.sid
    mid = '2e3r4t'
    return UserMessage.create user_id, message_id, mid

  end

  def self.get_sms(message_sid)
    twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
    twilio_token = "6e26775044f3087e7d9f44f003db29ae"
    twilio_phone_number = "+18027339326"
    begin
      @client = Twilio::REST::Client.new twilio_sid, twilio_token
      message = @client.account.messages.get(message_sid)
      return message.status
    rescue Twilio::REST::RequestError => e
      puts e.message
      return "Envío fallido" 
    end
  end

  #private
  def self.save_message(message, user_id)
    Message.connection
    new_message = Message.new
    new_message.message = message
    new_message.user_id = user_id
    new_message.save
    new_message.id
  end 
 

end
