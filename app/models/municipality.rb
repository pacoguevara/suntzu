class Municipality < ActiveRecord::Base
	self.primary_key = 'id'
	has_one :user
	validates_uniqueness_of :id
end
