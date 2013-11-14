class ConstantType < ActiveRecord::Base
    self.table_name = 'constant_type'
    self.inheritance_column = :ruby_type
    has_many :claim_audits, :class_name => 'ClaimAudit'    
    has_many :constant_responses, :class_name => 'ConstantResponse'    
    has_many :estimating_audits, :class_name => 'EstimatingAudit'    
    has_many :system_audit_categories, :class_name => 'SystemAuditCategory'    
    has_many :system_estimating_categories, :class_name => 'SystemEstimatingCategory'    
    has_many :system_estimating_categories, :class_name => 'SystemEstimatingCategory'    
end
