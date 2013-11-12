class AddingEmployeeFieldToClaimAwaitingAudit < ActiveRecord::Migration
  def change
    add_column :claim_awaiting_audit, :employee_id, :integer
    add_index :claim_awaiting_audit, :employee_id
    rename_column :claim_awaiting_audit, :loss, :estimate_date
  end
end
