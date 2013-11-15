class AddMinAmtFieldToClaimAuditQuestion < ActiveRecord::Migration
  def change
    add_column :claim_audit_questions, :min_amount, :integer, :default => 0
  end
end
