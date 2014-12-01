module Api
	module V1
		class MessagesController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				respond_with Message.all
			end
			def create
				params[:message]
				Message.save_message params[:message], current_user.id
				respond_with Message.last
			end

			def create_user_message 
				msg = params[:message]
				user_id = params[:user_id]
				cellphone = params[:cellphone]
				message_id = params[:message_id]
				Message.send_sms cellphone, msg, user_id, message_id

				#Message.send_sms({:user_id => user_id, :message_id => id})
				#h = {:user_id => user_id, :message_id => id}
				#respond_with h
			end
		end
	end
end