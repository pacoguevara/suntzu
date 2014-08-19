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
				respond_with Message.first
			end
		end
	end
end