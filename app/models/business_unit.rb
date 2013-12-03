class BusinessUnit < ActiveRecord::Base
	has_many :css, :class_name => 'Employee',:foreign_key => :business_unit_id,:conditions => { :case_type=>"css"}
	has_many :call_monthly_audit_entry, :class_name => 'CallMonthlyAuditEntry',:foreign_key => :business_unit_id
end
