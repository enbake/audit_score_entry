class CallAuditDetailFile < ActiveRecord::Base
  belongs_to :call_audit_question
  belongs_to :reference, :polymorphic => true

  scope :mean_for_question, -> (id) {where("call_audit_question_id=?",id).map(&:grade).sum.to_f}
  
end
