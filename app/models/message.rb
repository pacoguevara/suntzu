class Message < ActiveRecord::Base
	def self.send_sms(to, message)
		twilio_sid = "ACed7a7ef98a126abc33ff867370d890c9"
    twilio_token = "6e26775044f3087e7d9f44f003db29ae"
    twilio_phone_number = "+18027339326"
    #number_to_send_to = "+528341444418"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => "+52"+to,
      :body => message
    )
	end
end
