class ClaimAudit < ActiveRecord::Base
    self.table_name = 'claim_audit'
    belongs_to :constant_type, :class_name => 'ConstantType', :foreign_key => :audit_type_id    
    belongs_to :claim_awaiting_audit, :class_name => 'ClaimAwaitingAudit', :foreign_key => :claim_awaiting_audit_id    
    belongs_to :employee, :class_name => 'Employee', :foreign_key => :estimator_employee_id    
    belongs_to :employee, :class_name => 'Employee', :foreign_key => :reviewer_employee_id    
    has_many :claim_audit_notes, :class_name => 'ClaimAuditNote'    
end
