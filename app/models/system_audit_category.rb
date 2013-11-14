class SystemAuditCategory < ActiveRecord::Base
    self.table_name = 'system_audit_category'
    belongs_to :constant_type, :class_name => 'ConstantType', :foreign_key => :audit_type_id    
    has_many :system_audit_subcategories, :class_name => 'SystemAuditSubcategory'    
end
