class CreateClaimAuditDetailFiles < ActiveRecord::Migration
  def change
    create_table :claim_audit_detail_files do |t|
      t.string :category
      t.text :area
      t.string :answer
      t.decimal :exception
      t.text :note
      t.string :indicator
      t.integer :amount
      t.string :pct_exception
      t.references :claim_audit_question, index: true
      t.references :claim_audit_entry, index: true

      t.timestamps
    end
  end
end
