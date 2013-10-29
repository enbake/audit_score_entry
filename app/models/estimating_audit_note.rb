class EstimatingAuditNote < ActiveRecord::Base
    self.table_name = 'estimating_audit_note'


    belongs_to :estimating_audit, :class_name => 'EstimatingAudit', :foreign_key => :estimating_audit_id    
end
