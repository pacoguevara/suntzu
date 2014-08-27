module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				where_statment = "role LIKE ?"
				# if params.has_key? :email
				# 	where_statment=where_statment +"AND email LIKE ?"
				# end
				# if params.has_key? :cellphone
				# 	where_statment=where_statment +"AND email LIKE ?"
				# end
				# if params.has_key? :rnm
				# 	where_statment=where_statment +"AND email LIKE ?"
				# end
				# if params.has_key? :email
				# 	where_statment=where_statment +"AND email LIKE ?"
				# end
				# if params.has_key? :email
				# 	where_statment=where_statment +"AND email LIKE ?"
				# end
				# if params.has_key? :email
				# 	where_statment=where_statment +"AND email LIKE ?"
				# end
				respond_with User.where( 
					"role LIKE ? AND email LIKE ? AND cellphone LIKE ? AND rnm LIKE ? AND name LIKE ? AND last_name LIKE ? AND first_name LIKE ?  AND parent = ? AND gender LIKE ? ",
					"%#{params[:role]}%","%#{params[:email]}%","%#{params[:cellphone]}%", "%#{params[:rnm]}%", "%#{params[:name]}%", "%#{params[:last_name]}%", "%#{params[:first_name]}%", "#{params[:parent].to_i}", "%#{params[:gender]}%"
				 ).limit(User.per_page).offset(params[:page])
			end
			def parents
				parent = {"jugador"=>"subenlace", "subenlace"=>"enlace", "enlace"=>"coordinador", "coordinador"=>"grupo	"}
				users=User.where(:role => parent[params[:role]])
				u = User.new
				u.name="Nadie"
				u.first_name="_"
				u.last_name="_"
				u.id=0
				users.push u
				respond_with users 
			end
		end
		class PollingsController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				respond_with Polling.where( 
					"id = ?","%#{params[:id]}%"
				 )
			end
		end
	end
end