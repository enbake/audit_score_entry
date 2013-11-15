class ClaimAuditDetailFile < ActiveRecord::Base
  belongs_to :claim_audit_question
  belongs_to :claim_audit_entry

  validate :check_answers

  scope :adm_exception, -> (entry) {where("claim_audit_entry_id=? and category=?", entry.id, "Admin").map(&:exception).sum.to_f}
  scope :com_exception, -> (entry) {where("claim_audit_entry_id=? and category=?", entry.id, "Compliance").map(&:exception).sum.to_f}
  scope :over, -> (entry) {where("claim_audit_entry_id=? and indicator=?", entry.id, "Over").map(&:amount).sum.to_f}
  scope :under, -> (entry) {where("claim_audit_entry_id=? and indicator=?", entry.id, "Under").map(&:amount).sum.to_f}
  scope :adm_com_ans, -> (entry) {where("claim_audit_entry_id = ? and (category=? or category=?)", entry.id, "Admin", "Compliance").order("id asc")}
  scope :est_answers, -> (entry) {where(:claim_audit_entry_id=> entry.id, :category=>"Estimation Decisions")}
  scope :claim_audit_details, -> (entry) {where(:claim_audit_entry_id => entry.id)}

  private
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
