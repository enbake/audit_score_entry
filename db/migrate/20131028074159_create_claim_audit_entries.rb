class CreateClaimAuditEntries < ActiveRecord::Migration
  def change
    create_table :claim_audit_entries do |t|
      t.integer :reviewer
      t.datetime :review
      t.string :claim
      t.string :estimator
      t.float :overall_score
      t.float :admin_score
      t.string :compliance_score
      t.string :estimating_score
      t.float :leakage_amount

      t.timestamps
    end
  end
end
