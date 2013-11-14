class ConstantResponse < ActiveRecord::Base
    self.table_name = 'constant_response'
    belongs_to :constant_type, :class_name => 'ConstantType', :foreign_key => :response_type_id
end
