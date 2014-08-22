module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				
				respond_with User.where( 
					"email LIKE ? AND cellphone LIKE ? AND rnm LIKE ? AND name LIKE ? AND first_name LIKE ? AND last_name LIKE ? AND parent = ?	",
					"%#{params[:email]}%","%#{params[:cellphone]}%", "%#{params[:rnm]}%", "%#{params[:name]}%","%#{params[:name]}%","%#{params[:name]}%", "#{params[:parent]}"
				 )
				
			end
		end
	end
end