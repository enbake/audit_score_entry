class ClaimAuditDetailFile < ActiveRecord::Base
  belongs_to :claim_audit_question
  belongs_to :claim_audit_entry
end
