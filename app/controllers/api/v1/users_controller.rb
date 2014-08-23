module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				
				respond_with User.where( 
					"role LIKE ? AND email LIKE ? AND cellphone LIKE ? AND rnm LIKE ? AND name LIKE ? AND first_name LIKE ? AND last_name LIKE ? AND parent = ?	",
					"%#{params[:role]}%","%#{params[:email]}%","%#{params[:cellphone]}%", "%#{params[:rnm]}%", "%#{params[:name]}%","%#{params[:name]}%","%#{params[:name]}%", "#{params[:parent]}"
				 )
				
			end
		end
	end
end