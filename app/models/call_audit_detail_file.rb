class CallAuditDetailFile < ActiveRecord::Base
  belongs_to :call_audit_question
  belongs_to :reference, :polymorphic => true
end
