class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  self.table_name = 'employee'

  has_many :claim_audits, :class_name => 'ClaimAudit'
  has_many :claim_audits, :class_name => 'ClaimAudit'
  has_many :estimating_audits, :class_name => 'EstimatingAudit'
  has_many :estimating_audits, :class_name => 'EstimatingAudit'
  has_many :claim_audit_entries, :class_name => 'ClaimAuditEntry', :foreign_key => :reviewer_id
  has_many :claim_awaiting_audits, :class_name => 'ClaimAwaitingAudit', :foreign_key => :employee_id
  has_many :claim_awaiting_audits, :class_name => 'ClaimAwaitingAudit', :foreign_key => :uploader_employee_id
  has_many :unsaved_awaiting_audits, :class_name => 'UnsavedAwaitingAudit', :foreign_key => :creator_employee_id

end
