class Polling < ActiveRecord::Base
	has_many :votes, :through => :militants
	has_many :list_votation_header
end
