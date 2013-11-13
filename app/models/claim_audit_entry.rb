class ClaimAuditEntry < ActiveRecord::Base

  #include ActiveModel::Model
  attr_accessor :adm_ans, :com_ans, :est_ans

  belongs_to :reviewer, :class_name => 'Employee'#, :foreign_key => :reviewer_id
  #belongs_to :employee, :as => :reviewer
  has_many :claim_audit_detail_files
  has_many :claim_audit_comments

  after_save :question_details

  validates :claim, presence: true, uniqueness: true

  def self.cal_exp(attrs)
    result = 0
    attrs.each do |attr|
      result += attr[1]["exception"].to_i
    end
    return result
  end

  def self.cal_amt(attrs)
    over = 0
    under = 0
    attrs.each do |attr|
      if attr[1]["impact"] == "Over"
        over += attr[1]["amount"].to_i
      elsif attr[1]["impact"] == "Under"
        under += attr[1]["amount"].to_i
      end
    end
    return over, under
  end

  private
  
  def question_details
    adm_ans.each do |ans|
      question = ClaimAuditQuestion.find_by_question(ans[1]["question"])
      answer = ans[1]["answer"]
      exception = ans[1]["exception"]
      note = ans[1]["notes"]
      question_id = question.id
      question_category = question.category
      if answer =="No"
        self.claim_audit_detail_files.create!(category: question_category, claim_audit_question_id: question_id, answer: answer, exception: exception, note: note)
      else
        self.claim_audit_detail_files.create!(category: question_category, claim_audit_question_id: question_id, answer: answer, exception: '0', note: note)      
      end  
      
    end
    com_ans.each do |ans|
      question = ClaimAuditQuestion.find_by_question(ans[1]["question"])
      answer = ans[1]["answer"]
      exception = ans[1]["exception"]
      note = ans[1]["notes"]
      question_id = question.id
      question_category = question.category
      if answer =="No"
        self.claim_audit_detail_files.create!(category: question_category, claim_audit_question_id: question_id, answer: answer, exception: exception, note: note)
      else
        self.claim_audit_detail_files.create!(category: question_category, claim_audit_question_id: question_id, answer: answer, exception: '0', note: note)      
      end  
    end
    
    est_ans.each do |ans|
      question = ClaimAuditQuestion.find_by_question(ans[1]["ext_question"])
      answer = ans[1]["ext_answer"]
      indicator = ans[1]["impact"]
      amount = ans[1]["amount"]
      note = ans[1]["ext_notes"]
      question_id = question.id
      question_category = question.category
      if answer=="No"
       self.claim_audit_detail_files.create!(category: question_category, claim_audit_question_id: question_id, answer: answer, indicator: indicator, amount: amount, note: note)
     else
       self.claim_audit_detail_files.create!(category: question_category, claim_audit_question_id: question_id, answer: answer, indicator: indicator, amount: '0', note: note)
     end
   end
 end

end
