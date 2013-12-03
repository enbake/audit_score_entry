class CreateCallAuditEntries < ActiveRecord::Migration
  def change
    create_table :call_audit_entries do |t|
      t.integer :reviewer_id
      t.datetime :review
      t.integer :css_id
      t.string :call_type
      t.string :call_length
      t.datetime :call_date
      t.string :call_file_url
      t.float :total_score
      t.float :total_possible_score
      t.float :overall_score
      t.references :claim_awaiting_audit, index: true
      t.references :carrier_branch, index: true

      t.timestamps
    end
  end
end
