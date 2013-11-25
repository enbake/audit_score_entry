class AddUploadEmployeeRefToClaimAwaitingAudit < ActiveRecord::Migration
  def change
    add_reference :claim_awaiting_audit, :uploader_employee, index: true
    add_column :claim_awaiting_audit, :last_reviewed_date, :date
  end
end
