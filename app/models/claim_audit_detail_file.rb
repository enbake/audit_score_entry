class ClaimAuditDetailFile < ActiveRecord::Base
  belongs_to :claim_audit_question
  belongs_to :claim_audit_entry
  validate :check_answers
  def check_answers
    if answer == "No" and (category == "Admin" or category == "Compliance") 
      if exception == nil or note == nil
        self.errors[:base] << "Please fill the required fields"
      end
    elsif answer == "No" and category == "Estimation Decisions"
      if indicator == nil or note == nil or amount == nil
        self.errors[:base] << "Please fill the required fields"
      end
    end
  end

end
