module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index	
				where_statment = ""
				if params.has_key? :role
					if params[:role] != "jugador"
						where_statment = "lower(role) LIKE '%#{params[:role].downcase}%' "
					end
				end
				if params.has_key? :email
					if !where_statment.blank?
						where_statment = where_statment + " AND lower(email) LIKE "+
							"'%#{params[:email].downcase}%'"
					else
						where_statment = where_statment +" lower(email) LIKE "+
							"'%#{params[:email].downcase}%'"
					end
				end
				if params.has_key? :cellphone
					if !where_statment.blank?
						where_statment = where_statment +" AND lower(cellphone) LIKE "+
							"'%#{params[:cellphone].downcase}%'"
					else
						where_statment = where_statment +" lower(cellphone) LIKE "+
							"'%#{params[:cellphone].downcase}%'"
					end
				end
				if params.has_key? :rnm
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(rnm) LIKE "+
							"'%#{params[:rnm].downcase}%'"
					else
						where_statment=where_statment +" lower(rnm) LIKE "+
							"'%#{params[:rnm].downcase}%'"
					end
				end
				if params.has_key? :name
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(name) LIKE '"+
							"%#{params[:name].downcase}%'"
					else
						where_statment=where_statment +" lower(name) LIKE "+
							"'%#{params[:name].downcase}%'"
					end
				end
				if params.has_key? :first_name
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(first_name) LIKE "+
							"'%#{params[:first_name].downcase}%'"
					else
						where_statment=where_statment +" lower(first_name) LIKE "+
							"'%#{params[:first_name].downcase}%'"
					end
				end
				if params.has_key? :last_name
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(last_name) LIKE "+
							"'%#{params[:last_name].downcase}%'"
					else
						where_statment=where_statment +" lower(last_name) LIKE "+
							"'%#{params[:last_name].downcase}%'"
					end
				end
				if params.has_key? :parent
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(parent) LIKE "+
							"'%#{params[:parent].downcase}%'"
					else
						where_statment=where_statment +" lower(parent) LIKE "+
							"'%#{params[:parent].downcase}%'"
					end
				end
				if params.has_key? :gender
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(gender) LIKE "+
							"'%#{params[:gender].downcase}%'"
					else
						where_statment=where_statment +" lower(gender) LIKE "+
							"'%#{params[:gender].downcase}%'"
					end
				end
				if params.has_key? :ife_key
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(ife_key) LIKE "+
							"'%#{params[:ife_key].downcase}%'"
					else
						where_statment=where_statment +" lower(ife_key) LIKE "+
							"'%#{params[:ife_key].downcase}%'"
					end
				end
				if params.has_key? :register_date
					if !where_statment.blank?
						where_statment=where_statment +" AND register_date LIKE "+
							"'%#{params[:register_date].downcase}%'"
					else
						where_statment=where_statment +" register_date LIKE "+
							"'%#{params[:register_date].downcase}%'"
					end
				end
				if params.has_key? :bird
					if !where_statment.blank?
						where_statment=where_statment +" AND bird LIKE "+
							"'%#{params[:bird].downcase}%'"
					else
						where_statment=where_statment +" bird LIKE "+
							"'%#{params[:bird].downcase}%'"
					end
				end
				if params.has_key? :age
					if !where_statment.blank?
						where_statment=where_statment +" AND age = "+
						"#{params[:age]}"
					else
						where_statment=where_statment +" age = "+
						"'#{params[:age]}%'"
					end
				end
				if params.has_key? :section
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(section) LIKE "+
							"'%#{params[:section].downcase}%'"
					else
						where_statment=where_statment +" lower(section) LIKE "+
							"'%#{params[:section].downcase}%'"
					end
				end
				if params.has_key? :dto_fed
					if !where_statment.blank?
						where_statment=where_statment +" AND dto_fed = "+
							"#{params[:dto_fed].downcase}"
					else
						where_statment=where_statment +" dto_fed = "+
							"#{params[:dto_fed].downcase}"
					end
				end
				if params.has_key? :dto_loc
					if !where_statment.blank?
						where_statment=where_statment +" AND dto_loc = "+
							"#{params[:dto_loc].downcase}"
					else
						where_statment=where_statment +" dto_loc = "+
							"#{params[:dto_loc].downcase}"
					end
				end
				if params.has_key? :city
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(city) LIKE "+
							"'%#{params[:city].downcase}%'"
					else
						where_statment=where_statment +"  lower(city) LIKE "+
							"'%#{params[:city].downcase}%'"
					end
				end
				if params.has_key? :street_number
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(street_number) LIKE "+
							"'%#{params[:street_number].downcase}%'"
					else
						where_statment=where_statment +" lower(street_number) LIKE "+
							"'%#{params[:street_number].downcase}%'"
					end
				end
				if params.has_key? :outside_number
					if !where_statment.blank?
						where_statment=where_statment +" AND outside_number = "+
							"#{params[:outside_number].downcase}"
					else
						where_statment=where_statment +" outside_number = "+
							"#{params[:outside_number].downcase}"
					end
				end
				if params.has_key? :internal_number
					if !where_statment.blank?
						where_statment=where_statment +" AND internal_number = "+
							"#{params[:internal_number].downcase}"
					else
						where_statment=where_statment +" internal_number = "+
							"#{params[:internal_number].downcase}"
					end
				end
				if params.has_key? :neighborhood
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(neighborhood) LIKE "+
							"'%#{params[:neighborhood].downcase}%'"
					else
						where_statment=where_statment +" lower(neighborhood) LIKE "+
							"'%#{params[:neighborhood].downcase}%'"						
					end
				end
				if params.has_key? :zipcode
					if !where_statment.blank?
						where_statment=where_statment +" AND lower(zipcode) LIKE "+
							"'%#{params[:zipcode].downcase}%'"
					else
						where_statment=where_statment +" lower(zipcode) LIKE "+
							"'%#{params[:zipcode].downcase}%'"
					end
				end
				if params.has_key? :phone
					if !where_statment.blank?
						where_statment=where_statment +" AND phone LIKE "+
							"'%#{params[:phone].downcase}%'"
					else
						where_statment=where_statment +" phone LIKE "+
							"'%#{params[:phone].downcase}%'"
					end
				end		
				if params.has_key? :role
					users_count = User.where(where_statment).count
					users = User.where(where_statment).limit(User.per_page).
						offset(params[:page])
					
					users_ar = []
					users.each do |user|
						user_hash = {}
						user_hash[:id] = user.id
						user_hash[:name] = user.name
						user_hash[:first_name] = user.first_name
						user_hash[:last_name] = user.last_name
						user_hash[:gender] = user.gender
						user_hash[:age] = user.age
						user_hash[:section] = user.section
						user_hash[:city] = user.city
						user_hash[:role] = user.role
						user_hash[:neighborhood] = user.neighborhood
						user_hash[:parent] = user.parent == 0 ? "Sin Asignar" : User.find(user.parent).full_name
						users_ar.push user_hash
					end
					format  = {
						"data" => users_ar,
						"total" => users_count
					}
					respond_with format
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