class BusinessUnit < ActiveRecord::Base
	has_many :reviewers, :class_name => 'Employee',:foreign_key => :business_unit_id
end
