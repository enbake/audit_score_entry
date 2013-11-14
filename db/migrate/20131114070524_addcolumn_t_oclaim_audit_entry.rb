class AddcolumnTOclaimAuditEntry < ActiveRecord::Migration
  def change
    add_column :claim_audit_entries, :carrier_branch_id, :integer
    add_index :claim_audit_entries, :carrier_branch_id
  end
end
