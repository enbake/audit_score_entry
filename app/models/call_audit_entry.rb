class CallAuditEntry < ActiveRecord::Base
  attr_accessor :quest_answers,:comment,:business_unit

  belongs_to :claim_awaiting_audit
  belongs_to :carrier_branch
  belongs_to :css, :class_name => 'Employee'
  has_many :call_audit_detail_files,:as => :reference
  has_many :claim_audit_comments, :as => :reference
  validates :css_id, presence: true, uniqueness: true
  after_save :details_add,:add_comment,:add_business_unit

  private

  
  def details_add
    quest_answers.each do |ans|
      question = CallAuditQuestion.find_by_question(ans[1]["question"])
      grade = ans[1]["grade"].to_i
      note = ans[1]["notes"]
      sequence=ans[1]["sequence"].to_i
      weight=ans[1]["weight"].to_i
      score=weight*grade
      possible_score=weight*5
      question_id = question.id
      self.call_audit_detail_files.create!(call_audit_question_id: question_id, weight:weight,grade: grade,score:score,possible_score:possible_score, sequence: sequence, note: note)
    end
  end
  def add_comment
    if !comment.blank?
      self.claim_audit_comments.create(:comment=>comment, :written_by => self.reviewer_id)
    end
  end
  def add_business_unit
    Employee.find(self.css_id).update_attribute(:business_unit_id,business_unit)
  end
end