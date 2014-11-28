module Api
	module V1
		class MessagesController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				respond_with Message.all
			end
			def create
				params[:cellphone]
				params[:message]
				Message.send_sms params[:cellphone], params[:message]
				respond_with Message.last
			end

			def create_user_message 
				id = params[:id]
				user_id = params[:user_id]
				UserMessage.create({:user_id => user_id, :message_id => id})
				h = {:user_id => user_id, :message_id => id}
				respond_with h
			end
		end
	end
end