class AddingPolymorphicRelationToClaimAuditComment < ActiveRecord::Migration
  def change
    add_reference :claim_audit_comments, :reference, :polymorphic => true, index: true
    remove_column :claim_audit_comments, :claim_audit_entry_id, :integer
    add_column :claim_audit_comments, :auxiliary1, :text
    add_column :claim_audit_comments, :auxiliary2, :text
  end
end
