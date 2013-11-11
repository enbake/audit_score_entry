class ClaimAuditComment < ActiveRecord::Base
  belongs_to :claim_audit_entry
end
