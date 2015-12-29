class Message < ActiveRecord::Base
  belongs_to :user_message
  # @twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
  # @twilio_token = "6e26775044f3087e7d9f44f003db29ae"
  @twilio_sid = "AC74dd92a27a5be877c27c66a669fcc121"
  @twilio_token = "c9f94704135cbe61122f58770ded147c"
  @twilio_phone_number = "+18027339326"

  @sendgrid_user = 'fguevara'
  @sendgrid_password = 'aspg.1424'

  def self.send_sms(to, message, user_id, message_id)
  	number_to_send_to = "+528341444418"
    @twilio_client = Twilio::REST::Client.new @twilio_sid, @twilio_token
    response = @twilio_client.account.sms.messages.create(
      :from => "#{@twilio_phone_number}",
      :to => "+52"+to,
      :body => message
    )
    #puts response.status
    #puts response.sid
    mid = response.sid
    #mid = '2e3r4t'
    return UserMessage.create user_id, message_id, mid

  end

  def self.get_sms(message_sid)
    #twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
    #twilio_token = "6e26775044f3087e7d9f44f003db29ae"
    #twilio_phone_number = "+18027339326"
    begin
      @client = Twilio::REST::Client.new @twilio_sid, @twilio_token
      message = @client.account.messages.get(message_sid)
      return message.status
    rescue Twilio::REST::RequestError => e
      puts e.message
      return "failed" 
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
  
  def self.send_email(message, email)
    require 'sendgrid-ruby'
 
    client = SendGrid::Client.new(api_user: 'fguevara', api_key: 'aspg.1424')
     
    email = SendGrid::Mail.new do |m|
      m.to      = email
      m.from    = 'fguevara@tegik.com'
      m.subject = 'PAN'
      m.html    = message
    end
     
    puts client.send(email)
  end

end
