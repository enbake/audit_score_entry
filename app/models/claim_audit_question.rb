class ClaimAuditQuestion < ActiveRecord::Base
	has_many :claim_audit_detail_files
	scope :adm_headers, -> { where("category <> ?", "Estimation Decisions").map(&:category).uniq }
	scope :est_headers, -> { where("category = ?", "Estimation Decisions").map(&:category).uniq }
	scope :adm_questions, -> { where("category <> ?", "Estimation Decisions").map(&:question).uniq }
	scope :est_questions, -> { where("category = ?", "Estimation Decisions").map(&:question).uniq }
end
