class ListVotation < ActiveRecord::Base
	belongs_to :list_votation_header
	belongs_to :user
end
