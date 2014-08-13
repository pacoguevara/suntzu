class Vote < ActiveRecord::Base
	has_many :polling
	belongs_to :candidate
	belongs_to :militant
end
