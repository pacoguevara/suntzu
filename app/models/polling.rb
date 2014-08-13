class Polling < ActiveRecord::Base
	has_many :votes, :through => :militants
end
