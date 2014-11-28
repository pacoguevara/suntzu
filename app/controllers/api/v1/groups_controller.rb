module Api
	module V1
		class GroupsController < ApplicationController
			skip_authorization_check
			respond_to :json
			def grupos
				respond_with Group.all
			end
		end
	end
end