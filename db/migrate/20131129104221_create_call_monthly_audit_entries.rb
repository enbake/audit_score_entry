class CreateCallMonthlyAuditEntries < ActiveRecord::Migration
  def change
    create_table :call_monthly_audit_entries do |t|
      t.integer :reviewer_id
      t.datetime :review
      t.integer :css_id
      t.integer :business_unit_id
      t.datetime :calls_date
      t.integer :calls_count
      t.float :total_score
      t.float :total_possible_score
      t.float :overall_score
      t.float :monthly_total_score
      t.float :monthly_total_possible_score
      t.float :monthly_overall_score

      t.timestamps
    end
  end
end
