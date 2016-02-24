class Message < ActiveRecord::Base
  belongs_to :user_message

  # Credenciales del PAN
  #@twilio_sid = "AC74dd92a27a5be877c27c66a669fcc121"
  #@twilio_token = "c9f94704135cbe61122f58770ded147c"
  #@twilio_phone_number = "" #Falta proporcionar numero

  @sendgrid_user = '' #Ingresar credenciales de Sendgrid
  @sendgrid_password = '' #Ingresar password de Sendgrid

  def self.send_sms(to, message, user_id, message_id)
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

    client = SendGrid::Client.new(api_user: '', api_key: '') #Ingresar credenciales de SendGrid

    email = SendGrid::Mail.new do |m|
      m.to      = email
      m.from    = ''
      m.subject = 'PAN'
      m.html    = message
    end

    puts client.send(email)
  end

end
