class SystemAuditSubcategory < ActiveRecord::Base
    self.table_name = 'system_audit_subcategory'


    has_many :claim_audit_categories, :class_name => 'ClaimAuditCategory'    
    belongs_to :system_audit_category, :class_name => 'SystemAuditCategory', :foreign_key => :audit_category_id    
end
