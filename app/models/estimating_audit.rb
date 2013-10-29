class EstimatingAudit < ActiveRecord::Base
    self.table_name = 'estimating_audit'


    belongs_to :constant_type, :class_name => 'ConstantType', :foreign_key => :audit_type_id    
    belongs_to :carrier_branch, :class_name => 'CarrierBranch', :foreign_key => :carrier_branch_id    
    belongs_to :constant_estimating_system, :class_name => 'ConstantEstimatingSystem', :foreign_key => :estimating_system_id    
    belongs_to :employee, :class_name => 'Employee', :foreign_key => :estimator_employee_id    
    belongs_to :employee, :class_name => 'Employee', :foreign_key => :score_employee_id    
    has_many :estimating_audit_categories, :class_name => 'EstimatingAuditCategory'    
    has_many :estimating_audit_notes, :class_name => 'EstimatingAuditNote'    
end
