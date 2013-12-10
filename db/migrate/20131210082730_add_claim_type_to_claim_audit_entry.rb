class AddClaimTypeToClaimAuditEntry < ActiveRecord::Migration
  def change
    add_column :claim_audit_entries, :claim_type, :string
  end
end
