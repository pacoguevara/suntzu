class Vote < ActiveRecord::Base
	has_one :militant
	has_one :candidate
end
