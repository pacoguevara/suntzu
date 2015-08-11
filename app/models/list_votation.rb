class ListVotation < ActiveRecord::Base
	belongs_to :list_votation_header
	belongs_to :user

	def self.new_lista_nominal(params)
		if params[:prueba][:municipio] == "-1"
			@us = User.all
		else
			@us = User.where("municipality_id = ? AND register_date >= ? AND register_date <= ? AND bird >= ? AND bird <=?",
				params[:prueba][:municipio], params[:prueba][:register_start_date].to_date, params[:prueba][:register_end_date].to_date, params[:prueba][:bird_start_date].to_date, params[:prueba][:bird_end_date].to_date)		
		end

		lvArray = Array.new

		if !@us.empty?
			lvh = ListVotationHeader.new
			lvh.polling_id = params[:prueba][:polling]
			lvh.save
			cont = 1
			@us.each do |u|
				newlv = ListVotation.new
				newlv.list_votation_header_id = lvh.id
				newlv.user_id = u.id
				newlv.number = cont
				newlv.created_at = Time.zone.now
				newlv.updated_at = Time.zone.now
				cont+=1
				if u.temp_chek.nil?
					newlv.check = false
				else
					newlv.check = true
				end
				newlv.save!
				lvArray.push(newlv)
			end
		end
		return lvArray
	end
end
