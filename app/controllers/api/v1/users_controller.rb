module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				
				if params.has_key? :role
					where_statment = "lower(role) LIKE '%#{params[:role].downcase}%' "
				end
				if params.has_key? :email
					where_statment=where_statment +"AND lower(email) LIKE '%#{params[:email].downcase}%'"
				end
				if params.has_key? :cellphone
					where_statment=where_statment +"AND lower(cellphone) LIKE '%#{params[:cellphone].downcase}%'"
				end
				if params.has_key? :rnm
					where_statment=where_statment +"AND lower(rnm) LIKE '%#{params[:rnm].downcase}%'"
				end
				if params.has_key? :name
					where_statment=where_statment +"AND lower(name) LIKE '%#{params[:name].downcase}%'"
				end
				if params.has_key? :first_name
					where_statment=where_statment +"AND lower(first_name) LIKE '%#{params[:first_name].downcase}%'"
				end
				if params.has_key? :last_name
					where_statment=where_statment +"AND lower(last_name) LIKE '%#{params[:last_name].downcase}%'"
				end
				if params.has_key? :parent
					where_statment=where_statment +"AND lower(parent) LIKE '%#{params[:parent].downcase}%'"
				end
				if params.has_key? :gender
					where_statment=where_statment +"AND lower(gender) LIKE '%#{params[:gender].downcase}%'"
				end
				if params.has_key? :ife_key
					where_statment=where_statment +"AND lower(ife_key) LIKE '%#{params[:ife_key].downcase}%'"
				end
				if params.has_key? :register_date
					where_statment=where_statment +"AND register_date LIKE '%#{params[:register_date].downcase}%'"
				end
				if params.has_key? :bird
					where_statment=where_statment +"AND bird LIKE '%#{params[:bird].downcase}%'"
				end
				if params.has_key? :age
					where_statment=where_statment +"AND age LIKE '%#{params[:age].downcase}%'"
				end
				if params.has_key? :section
					where_statment=where_statment +"AND lower(section) LIKE '%#{params[:section].downcase}%'"
				end
				if params.has_key? :dto_fed
					where_statment=where_statment +"AND dto_fed = #{params[:dto_fed].downcase}"
				end
				if params.has_key? :dto_loc
					where_statment=where_statment +"AND dto_loc = #{params[:dto_loc].downcase}"
				end
				if params.has_key? :city
					where_statment=where_statment +"AND lower(city) LIKE '%#{params[:city].downcase}%'"
				end
				if params.has_key? :street_number
					where_statment=where_statment +"AND lower(street_number) LIKE '%#{params[:street_number].downcase}%'"
				end
				if params.has_key? :outside_number
					where_statment=where_statment +"AND outside_number = #{params[:outside_number].downcase}"
				end
				if params.has_key? :internal_number
					where_statment=where_statment +"AND internal_number = #{params[:internal_number].downcase}"
				end
				if params.has_key? :neighborhood
					where_statment=where_statment +"AND lower(neighborhood) LIKE '%#{params[:neighborhood].downcase}%'"
				end
				if params.has_key? :zipcode
					where_statment=where_statment +"AND lower(zipcode) LIKE '%#{params[:zipcode].downcase}%'"
				end
				if params.has_key? :phone
					where_statment=where_statment +"AND phone LIKE '%#{params[:phone].downcase}%'"
				end		
				if params.has_key? :role
					respond_with User.where(where_statment).limit(User.per_page).offset(params[:page])
				else
					respond_with User.all.select("#{params[:cols]}")
				end
			end
			def groups
				groups_by_name = {}
				User.all.group(:group_id).count.to_a.each do |k,v|
					if k.nil?
						group_name = "Sin Grupo"
					else
						group_name = Group.find(k).name
					end
					groups_by_name[group_name] = v
				end
				respond_with groups_by_name.to_a
			end
			def show
				if !params.has_key? :cols
					respond_with User.find params[:id] 
				else
					respond_with User.where(:id=>params[:id]).select("#{params[:cols]}")
				end
			end
			def update
				@user = User.find(params[:id])
				respond_with @user do |format|
					if @user.update_attributes user_params
						format.json {render json: @user.to_json, status: :ok}
					else
						format.json {render json: error_hash.to_json(root: :error), status: :unprocessable_entity }
					end
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
			private
			def user_params
     		params.require(:user).permit(:register_date, :first_name, :last_name, :name, :bird, :rnm, :linking, :sub_linking, :group_id, :suburb, :section, :sector, :cp, :phone, :cellphone, :email, :password, :password_confirmation, :role, :age, :gender, :city, :street_number, :neighborhood, :parent, :group_id, :dto_fed, :dto_loc, :ife_key, :internal_number, :outside_number, :lat, :lng)
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