class SystemEstimatingCategory < ActiveRecord::Base
    self.table_name = 'system_estimating_category'


    has_many :estimating_audit_categories, :class_name => 'EstimatingAuditCategory'    
    belongs_to :constant_type, :class_name => 'ConstantType', :foreign_key => :audit_type_id    
    belongs_to :constant_type, :class_name => 'ConstantType', :foreign_key => :metric_type_id    
end
