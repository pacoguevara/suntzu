module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				where_statment = "role LIKE '%#{params[:role]}%' "
				if params.has_key? :email
					where_statment=where_statment +"AND email LIKE '%#{params[:email]}%'"
				end
				if params.has_key? :cellphone
					where_statment=where_statment +"AND cellphone LIKE '%#{params[:cellphone]}%'"
				end
				if params.has_key? :rnm
					where_statment=where_statment +"AND rnm LIKE '%#{params[:rnm]}%'"
				end
				if params.has_key? :name
					where_statment=where_statment +"AND name LIKE '%#{params[:name]}%'"
				end
				if params.has_key? :first_name
					where_statment=where_statment +"AND first_name LIKE '%#{params[:first_name]}%'"
				end
				if params.has_key? :last_name
					where_statment=where_statment +"AND last_name LIKE '%#{params[:last_name]}%'"
				end
				if params.has_key? :parent
					where_statment=where_statment +"AND parent LIKE '%#{params[:parent]}%'"
				end
				if params.has_key? :gender
					where_statment=where_statment +"AND gender LIKE '%#{params[:gender]}%'"
				end
				respond_with User.where(where_statment).limit(User.per_page).offset(params[:page])
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