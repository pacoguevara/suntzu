module Api
	module V1
		class UsersController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index	
				where_statment = ""
				if params.has_key? :role
					if params[:role] != "jugador"
						where_statment = "lower(role) = '#{params[:role].downcase}' "
					end
				end
				if params.has_key? :municipality_id 
			 		if params[:municipality_id].to_s != "-1"
						if !where_statment.blank?
							where_statment = where_statment +" AND municipality_id = '#{params[:municipality_id]}'"
						else
							where_statment = where_statment +" municipality_id = '#{params[:municipality_id]}'"
						end
					end
				end
				if params.has_key? :register_start
					ftime = Time.parse( params[:register_start] )
        	start = ftime.to_formatted_s( :db )
        	puts params[:register_start]
					if !where_statment.blank?
						where_statment = where_statment +" AND register_date >= '#{start}'"
					else
						where_statment = where_statment +" register_date >= '#{start}'"
					end
				end
				if params.has_key? :register_end
					ftime = Time.parse( params[:register_end] )
        	date_end = ftime.to_formatted_s( :db )

					if !where_statment.blank?
						where_statment = where_statment +" AND register_date <= '#{date_end}'"
					else
						where_statment = where_statment +" register_date <= '#{date_end}'"
					end
				end
				if params.has_key? :bird_start
					ftime = Time.parse( params[:bird_start] )
        	start = ftime.to_formatted_s( :db )

					if !where_statment.blank?
						where_statment = where_statment +" AND bird >= '#{start}'"
					else
						where_statment = where_statment +" bird >= '#{start}'"
					end
				end
				if params.has_key? :bird_end
					ftime = Time.parse( params[:bird_end] )
        	date_end = ftime.to_formatted_s( :db )

					if !where_statment.blank?
						where_statment = where_statment +" AND bird <= '#{date_end}'"
					else
						where_statment = where_statment +" bird <= '#{date_end}'"
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
						where_stafull_nametment=where_statment +" AND lower(ife_key) LIKE "+
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
				if params.has_key? :sub_enlace_id
					if params[:sub_enlace_id] != '0'
						if !where_statment.blank?
							where_statment=where_statment +" AND subenlace_id = "+
							"#{params[:sub_enlace_id]}"
						else
							where_statment=where_statment +" subenlace_id = "+
							"#{params[:sub_enlace_id]}"
						end
						puts "a ver que "+where_statment.to_s
					else
					end
				end		
				if params.has_key? :enlace_id
					if params[:enlace_id] != '0'
						if !where_statment.blank?
							where_statment=where_statment +" AND enlace_id = "+
							"#{params[:enlace_id]}"
						else
							where_statment=where_statment +" enlace_id = "+
							"#{params[:enlace_id]}"
						end
					end
				end
				if params.has_key? :coordinador_id
					if params[:coordinador_id] != '0'
						if !where_statment.blank?
							where_statment=where_statment +" AND coordinador_id = "+
							"#{params[:coordinador_id]}"
						else
							where_statment=where_statment +" coordinador_id = "+
							"#{params[:coordinador_id]}"
						end
					end
				end
				if params.has_key? :role
					users_count = User.where(where_statment).count
					if params.has_key? :page
						users = User.where(where_statment).limit(User.per_page).
						offset(params[:page])
					else
						users = User.where(where_statment).limit(User.per_page).offset(0)
					end					
					users_ar = []
				 	@subenlace = User.where(:role => "subenlace")
			    @enlace = User.where(:role => "enlace")
			    @coordinador = User.where(:role => "coordinador")
					users.each do |user|
						puts user.id
						user_hash = {}
						user_hash[:id] = user.id
						user_hash[:name] = user.name
						user_hash[:first_name] = user.first_name
						user_hash[:last_name] = user.last_name
						user_hash[:full_name] = user.full_name
						user_hash[:gender] = user.gender
						user_hash[:age] = user.age
						user_hash[:section] = user.section
						user_hash[:city] = !user.municipality_id.blank? ? user.municipality.name : ''
						user_hash[:role] = user.role
						user_hash[:temp_chek] = user.temp_chek
						user_hash[:municipality_id] = user.municipality_id
						user_hash[:neighborhood] = user.neighborhood
						user_hash[:subenlace_id] = user.subenlace_id
						user_hash[:enlace_id] = user.enlace_id
						user_hash[:coordinador_id] = user.coordinador_id
						users_ar.push user_hash
					end
					format  = {
						"data" => users_ar,
						"subenlaces" => @subenlace,
						"enlaces" =>  @enlace,
						"coordinadores" => @coordinador,
						"total" => users_count
					}
					respond_with format
				else
					respond_with User.all.select("#{params[:cols]}")
				end
			end
			def municipality
				respond_with users = User.joins(:municipality)
					.group("municipalities.name").limit(10).count(:municipality_id)
			end
			def enlace
				user = User.find(params[:id2])
				if params[:id1] == "vacio"
					if params[:tipo] == "1"
						user.subenlace_id = 0
					elsif params[:tipo] == "2"
						user.enlace_id = 0
						user.subenlace_id = 0
					elsif params[:tipo] == "3"
						user.coordinador_id = 0
						user.subenlace_id = 0
						user.enlace_id = 0		
					end
				else
					if params[:tipo] == "1"
						puts "es UNO"
						user.subenlace_id = params[:id1]
						user2 = User.find(params[:id1])
						if !user2.enlace_id.nil? && user2.enlace_id != 0
							user.enlace_id = user2.enlace_id
						else
							user.enlace_id = 0
						end
						if !user2.coordinador_id.nil? && user2.coordinador_id != 0
							user.coordinador_id = user2.coordinador_id	
						else
							user.coordinador_id = 0
						end
					elsif params[:tipo] == "2"
						puts "es DOS"
						user.enlace_id = params[:id1]
						user2 = User.find(params[:id1])
						if user2.coordinador_id && user2.coordinador_id != 0
							user.coordinador_id = user2.coordinador_id
						else
							user.coordinador_id = 0
						end
						user.subenlace_id = 0
					elsif params[:tipo] == "3"
						puts "es TRES"
						user.coordinador_id = params[:id1]
						user.subenlace_id = 0
						user.enlace_id = 0
					end
					
				end
				

				user.save!
				respond_with true
			end
			def get_parent
				h = Hash.new				
				puts "params "+params.to_s
				if params[:id1] != "vacio"
					user = User.find(params[:id1])	
					if params[:tipo] == "1"
						if user.enlace_id && user.enlace_id != 0
							user1 = User.find(user.enlace_id)
							h[:user_id] = user1.id
							h[:name] = user1.full_name
						end
						if user.coordinador_id && user.coordinador_id != 0
							user1 = User.find(user.coordinador_id)
							h[:user_id2] = user1.id
							h[:name2] = user1.full_name
						end
					elsif params[:tipo] == "2"
						if user.subenlace_id && user.subenlace_id != 0
							user1 = User.find(user.subenlace_id)
							h[:user_id] = user1.id
							h[:name] = user1.full_name
						else
							h[:user_id] = 0
							h[:name] = ""
						end
						if user.coordinador_id && user.coordinador_id != 0
							user1 = User.find(user.coordinador_id)
							h[:user_id2] = user1.id
							h[:name2] = user1.full_name
						end
					elsif params[:tipo] == "3"
						if user.subenlace_id && user.subenlace_id != 0
							user1 = User.find(user.subenlace_id)
							h[:user_id] = user1.id
							h[:name] = user1.full_name
						else
							h[:user_id] = 0
							h[:name] = ""
						end
						if user.enlace_id && user.enlace_id != 0
							user1 = User.find(user.enlace_id)
							h[:user_id2] = user1.id
							h[:name2] = user1.full_name
						else
							h[:user_id2] = 0
							h[:name2] = ""
						end
					end			
					#if params[:tipo] == "1"
					#	if user.enlace_id && user.enlace_id != 0
					#		parent = User.find(user.enlace_id)
					#		h[:user_id] = parent.id
					#		h[:name] = parent.full_name
					#		if parent.coordinador_id && parent.coordinador_id != 0
					#			bisparent = User.find(parent.coordinador_id)
					#			h[:user_id2] = bisparent.id
					#			h[:name2] = bisparent.full_name
					#		else
					#			h[:user_id2] = 0
					#			h[:name2] = ""
					#		end
					#	else
					#		h[:user_id] = 0
				#			h[:name] = ""
				#			h[:user_id2] = 0
				#			h[:name2] = ""
				#		end
					#elsif params[:tipo] == "2" 
				#		parent = User.find(user.coordinador_id)
				#		h[:user_id] = parent.id
				##		h[:name] = parent.full_name
				##		h[:user_id2] = 0
				#	#	h[:name2] = ""					
			#		elsif params[:tipo] == "3"
					#end
				else
					user = User.find(params[:id2])
					if params[:tipo] == "1"
						h[:user_id] = nil
						h[:name] = "vacio"
						h[:user_id2] = nil
						h[:name2] = "vacio"
					elsif params[:tipo] == "2"
						h[:user_id] = 0
						h[:name] = "vacio"
						h[:user_id2] = nil
						h[:name2] = "vacio"
					elsif params[:tipo] == "3"
						user.subenlace_id = 0
						user.subenlace_id = 0
					end

				end		
				respond_with h		
					
			end
			def get_list_votation
				puts "son los params y asi "+params.to_s
				swhere = ""
				if params[:number]
					swhere = "number = "+params[:number]
				end
				@lvh = ListVotationHeader.find(params[:polling_id])
				if swhere == ""
    				@listvotation = ListVotation.where(:list_votation_header_id => @lvh.id).order(:number)
    			else
    				@listvotation = ListVotation.where(:list_votation_header_id => @lvh.id).where(swhere).order(:number)
				end
				
    			user_hash = Hash.new
    			user_ar = Array.new
    			@listvotation.each do |l|
    				user_hash = {}
    				user_hash[:number] = l.number
    				user_hash[:name] = l.user.full_name
    				user_hash[:check] = l.check
    				user_hash[:id] = l.id
    				user_ar.push user_hash
    			end
				
				respond_with user_ar
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
						format.json {render json: error_hash.to_json(root: :error), 
							status: :unprocessable_entity }
					end
				end
			end
			def subenlaces
				respond_with User.where :role => 'subenlace'	
			end
			def enlaces
				respond_with User.where :role => 'enlace'
			end
			def coordinadores
				respond_with User.where :role => 'coordinador'
			end
			def parents
				parent = {"jugador"=>"subenlace", "subenlace"=>"enlace", 
					"enlace"=>"coordinador", "coordinador"=>"grupo	"}
				users=User.where(:role => parent[params[:role]])
				u = User.new
				u.name="Nadie"
				u.first_name="_"
				u.last_name="_"
				u.id=0
				users.push u
				respond_with users 
			end
			def list_votation
				lvh = ListVotationHeader.new
				lvh.polling_id = params[:prueba][:polling]
				puts "*************************** params"+params.to_s
				@us = User.where("municipality_id = ? AND register_date >= ? AND register_date <= ? AND bird >= ? AND bird <=?",params[:prueba][:municipio], params[:prueba][:register_start_date].to_date, params[:prueba][:register_end_date].to_date, params[:prueba][:bird_start_date].to_date, params[:prueba][:bird_end_date].to_date)
				@lvArray = Array.new
				if !@us.empty?
					lvh.save
					cont = 1
					@us.each do |u|
						newlv = ListVotation.new
						newlv.list_votation_header_id = lvh.id
						newlv.user_id = u.id
						newlv.number = cont
						cont+=1
						if u.temp_chek.nil?
							newlv.check = false
						else
							newlv.check = true
						end
						newlv.save!
						@lvArray.push(newlv)
					end
				else
					puts "************************************ es empty"
				end
				respond_with @lvArray
			end
			def list_check
				vl = ListVotation.find(params[:user][:votation_list_id])
				if params[:user][:temp_chek] == "true"
					vl.check = true
				else
					vl.check = false
				end
				vl.save
				respond_with true
			end
			private
			def user_params
     		params.require( :user ).permit(
     			:register_date, 
     			:first_name, 
     			:last_name, 
     			:name, 
     			:bird, 
     			:rnm, 
     			:linking, 
     			:sub_linking, 
     			:group_id, 
     			:suburb, 
     			:section, 
     			:sector, 
     			:cp, 
     			:phone, 
     			:cellphone, 
     			:email, 
     			:password, 
     			:password_confirmation, 
     			:role, 
     			:age, 
     			:gender, 
     			:city, 
     			:street_number, 
     			:neighborhood, 
     			:parent, 
     			:group_id, 
     			:dto_fed, 
     			:dto_loc, 
     			:ife_key, 
     			:internal_number, 
     			:outside_number, 
     			:lat, 
     			:lng, 
     			:temp_chek)
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