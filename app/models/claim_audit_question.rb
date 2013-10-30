class ClaimAuditQuestion < ActiveRecord::Base
  scope :adm_headers, -> { where("category <> ?", "Estimation Decisions").map(&:category).uniq }
  scope :est_headers, -> { where("category = ?", "Estimation Decisions").map(&:category).uniq }
  scope :adm_questions, -> { where("category <> ?", "Estimation Decisions").map(&:question).uniq }
  scope :est_questions, -> { where("category = ?", "Estimation Decisions").map(&:question).uniq }
end
