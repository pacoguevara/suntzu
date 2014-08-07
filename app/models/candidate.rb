class Candidate < ActiveRecord::Base
	has_many :groups
	belongs_to :candidate_votations
end
