class Group < ActiveRecord::Base
	has_many :militant
	belongs_to :candidate
end
