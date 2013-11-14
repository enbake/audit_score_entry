class AddcolumntoclaimAuditEntry < ActiveRecord::Migration
   def change
    add_column :claim_audit_entries, :claim_awaiting_audit_id, :integer
    add_index :claim_audit_entries, :claim_awaiting_audit_id
  end
end
