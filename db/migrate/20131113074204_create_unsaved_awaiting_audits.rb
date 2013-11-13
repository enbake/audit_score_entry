class CreateUnsavedAwaitingAudits < ActiveRecord::Migration
  def change
    create_table :unsaved_awaiting_audits do |t|
      t.string :claim_number
      t.string :claim_type
      t.integer :carrier_branch_id
      t.decimal :severity
      t.decimal :duration_net
      t.date :estimate_date
      t.boolean :active
      t.integer :created_employee_id
      t.datetime :completed
      t.integer :completed_employee_id
      t.integer :employee_id
      t.datetime :created
      t.datetime :timestamp
      t.references :employee_master
      t.string :batch

      t.timestamps
    end
  end
end
