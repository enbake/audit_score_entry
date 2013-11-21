class ClaimAuditCategory < ActiveRecord::Base
    self.table_name = 'claim_audit_category'
    belongs_to :system_audit_subcategory, :class_name => 'SystemAuditSubcategory', :foreign_key => :audit_subcategory_id    
end