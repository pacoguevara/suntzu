class Group < ActiveRecord::Base
	has_many :militant
	belongs_to :candidate
	belongs_to :user
end
