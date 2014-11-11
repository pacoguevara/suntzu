class ListVotationHeader < ActiveRecord::Base
	has_many :list_votations
	belongs_to :polling
	
end