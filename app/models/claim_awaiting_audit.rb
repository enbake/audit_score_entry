class ClaimAwaitingAudit < ActiveRecord::Base
    self.table_name = 'claim_awaiting_audit'

  has_many :claim_audits, :class_name => 'ClaimAudit'
  belongs_to :carrier_branch, :class_name => 'CarrierBranch', :foreign_key => :carrier_branch_id
  belongs_to :estimator, :class_name => 'Employee', :foreign_key => :employee_id
  has_and_belongs_to_many :employees, join_table: :claim_awaiting_audits_employees#, :class_name => 'Employee', :foreign_key => :uploader_employee_id
  has_one :claim_audit_entry, :class_name => 'ClaimAuditEntry',:dependent => :destroy

  validate :check_estimator_and_carrier_agent
  validates_uniqueness_of :claim_number, :scope => [:claim_type]

  private

  def check_estimator_and_carrier_agent
    carrier_branch_exists = CarrierBranch.all.map(&:id).include? carrier_branch_id
    estimator_exists = Employee.all.map(&:id).include? employee_id
    unless carrier_branch_exists and estimator_exists
      self.errors[:base] << "Content invalid"
    end
  end

end
