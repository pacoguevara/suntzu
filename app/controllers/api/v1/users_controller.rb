module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index			
				respond_with User.where( 
					"role LIKE ? AND email LIKE ? AND cellphone LIKE ? AND rnm LIKE ? AND (name LIKE ? OR last_name LIKE ? OR first_name LIKE ? ) AND parent = ? AND gender LIKE ? ",
					"%#{params[:role]}%","%#{params[:email]}%","%#{params[:cellphone]}%", "%#{params[:rnm]}%", "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:name]}%", "#{params[:parent].to_i}", "%#{params[:gender]}%"
				 ).limit(User.per_page).offset(params[:page])
			end
			def parents
				parent = {"jugador"=>"subenlace", "subenlace"=>"enlace", "enlace"=>"coordinador", "coordinador"=>"grupo	"}
				respond_with User.where(:role => parent[params[:role]])
			end
		end
	end
end