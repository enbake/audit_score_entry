class CreateClaimAuditComments < ActiveRecord::Migration
  def change
    create_table :claim_audit_comments do |t|
      t.references :claim_audit_entry, index: true
      t.text :comment
      t.string :written_by

      t.timestamps
    end
  end
end
