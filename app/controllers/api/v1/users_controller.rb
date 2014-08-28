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
				if params.has_key? :ife_key
					where_statment=where_statment +"AND ife_key LIKE '%#{params[:ife_key]}%'"
				end
				if params.has_key? :register_date
					where_statment=where_statment +"AND register_date LIKE '%#{params[:register_date]}%'"
				end
				if params.has_key? :bird
					where_statment=where_statment +"AND bird LIKE '%#{params[:bird]}%'"
				end
				if params.has_key? :age
					where_statment=where_statment +"AND age LIKE '%#{params[:age]}%'"
				end
				if params.has_key? :section
					where_statment=where_statment +"AND gender LIKE '%#{params[:section]}%'"
				end
				if params.has_key? :dto_fed
					where_statment=where_statment +"AND dto_fed = #{params[:dto_fed]}"
				end
				if params.has_key? :dto_loc
					where_statment=where_statment +"AND dto_loc = #{params[:dto_loc]}"
				end
				if params.has_key? :city
					where_statment=where_statment +"AND city LIKE '%#{params[:city]}%'"
				end
				if params.has_key? :street_number
					where_statment=where_statment +"AND street_number LIKE '%#{params[:street_number]}%'"
				end
				if params.has_key? :outside_number
					where_statment=where_statment +"AND outside_number = #{params[:outside_number]}"
				end
				if params.has_key? :internal_number
					where_statment=where_statment +"AND internal_number = #{params[:internal_number]}"
				end
				if params.has_key? :neighborhood
					where_statment=where_statment +"AND neighborhood LIKE '%#{params[:neighborhood]}%'"
				end
				if params.has_key? :zipcode
					where_statment=where_statment +"AND zipcode LIKE '%#{params[:zipcode]}%'"
				end
				if params.has_key? :phone
					where_statment=where_statment +"AND phone LIKE '%#{params[:phone]}%'"
				end		
				respond_with User.where(where_statment).limit(User.per_page).offset(params[:page])
			end
			def show
				if !params.has_key? :cols
					respond_with User.find params[:id] 
				else
					respond_with User.where(:id=>params[:id]).select("#{params[:cols]}")
				end
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