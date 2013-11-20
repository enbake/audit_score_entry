class ClaimAuditQuestion < ActiveRecord::Base

  has_many :claim_audit_detail_files

  scope :adm_headers, -> { where("category <> ?", "Estimation Decisions").map(&:category).uniq }
  scope :est_headers, -> { where("category = ?", "Estimation Decisions").map(&:category).uniq }
  scope :adm_questions, -> { where("category <> ?", "Estimation Decisions").map(&:question).uniq }
  scope :est_questions, -> { where("category = ?", "Estimation Decisions").map(&:question).uniq }

  def min_exception=(value)
    if category == "Estimation Decisions" and value != nil
      self[:min_exception] = ""
    else
      self[:min_exception] = value
    end
  end

  def max_exception=(value)
    if category == "Estimation Decisions" and value != nil
      self[:max_exception] = ""
    else
      self[:max_exception] = value
    end
  end

  def min_amount=(value)
    if (category == "Admin" or category == "Compliance") and value != 0
      self[:min_amount] = 0
    else
      self[:min_amount] = value
    end
  end

end
