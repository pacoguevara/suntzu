module Api
	module V1
		class PollingsController < ApplicationController
			skip_authorization_check
			respond_to :json
			def index
				respond_with Polling.all
			end
			def groups
				id = params[:id]
				groups = {}
				all_groups = Group.all
				data = ListVotation.joins(:list_votation_header).joins({:user => :group})
					.where("list_votation_headers.polling_id = #{id}")
					.where("list_votations.check = 't'")
					.select('groups.name, users.group_id, '+
						'extract(hour from list_votations.updated_at) AS hour')

				data.uniq.pluck('groups.name').each do |d|
					groups[d] = []
				end
				response = []
				all_groups.each do |g|
					hours = (1..24).to_a
					(0..23).each{ |h| hours[h] = 0}
					data.each do |d|
						(7..18).each do |h|
							if d['hour'].to_i == h && d['name'] == g.name
								hours[h] = hours[h] + 1
							end
						end
					end
					
					hash = {'name' => g.name, 'data' => hours[7..18]}
					response.push hash
				end
				
				respond_with response
			end
			def groups_show
				id = params[:id]
				group_id = params[:group]
				coordinators = User.where(:role=>'coordinador')
				groups = {}

				data = ListVotation.joins(:list_votation_header).joins(:user)
					.where("list_votation_headers.polling_id = #{id}")
					.where("users.group_id = #{group_id}")
					.where("list_votations.check = 't'")
					.select('extract(hour from list_votations.updated_at) AS hour, '+
						'users.coordinador_id, users.id AS user_id')
				response = []
					coordinators.each do |cid|
						hours = (1..24).to_a
						(0..23).each{ |h| hours[h] = 0}
						data.each do |d|
							#this is the duration of the votation from 8 to 19 hrs
							(7..18).each do |h|
								if d['hour'].to_i == h && d['coordinador_id'] == cid.id
									hours[h] = hours[h] + 1
								end
							end
						end	
						
						hash = {'name' => cid.full_name, 'data' => hours[7..18]}
						response.push hash
					end
				
				
				respond_with response
			end
		end
	end
end