class CarrierBranch < ActiveRecord::Base
	self.table_name = 'carrier_branch'
	has_many :claim_awaiting_audits, :class_name => 'ClaimAwaitingAudit'
	has_many :claim_audit_entries, :class_name => 'ClaimAuditEntry'    
	has_many :estimating_audits, :class_name => 'EstimatingAudit'    
end
