class Vote < ActiveRecord::Base
	belongs_to :polling
	belongs_to :candidate
end
