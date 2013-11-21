class CallAuditEntry < ActiveRecord::Base
  belongs_to :claim_awaiting_audit
  belongs_to :carrier_branch
  belongs_to :reviewer, :class_name => 'Employee'
  has_many :call_audit_detail_files,:as => :reference
  validates :css_id, presence: true, uniqueness: true
end