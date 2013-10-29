class ConstantEstimatingSystem < ActiveRecord::Base
    self.table_name = 'constant_estimating_system'


    has_many :estimating_audits, :class_name => 'EstimatingAudit'    
end
