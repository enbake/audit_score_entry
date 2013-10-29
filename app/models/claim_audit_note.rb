class ClaimAuditNote < ActiveRecord::Base
    self.table_name = 'claim_audit_note'


    belongs_to :claim_audit, :class_name => 'ClaimAudit', :foreign_key => :claim_audit_id    
end
