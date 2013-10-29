class EstimatingAuditCategory < ActiveRecord::Base
    self.table_name = 'estimating_audit_category'


    belongs_to :estimating_audit, :class_name => 'EstimatingAudit', :foreign_key => :estimating_audit_id    
    belongs_to :system_estimating_category, :class_name => 'SystemEstimatingCategory', :foreign_key => :estimating_category_id    
end
