class CreateCallAuditDetailFiles < ActiveRecord::Migration
  def change
    create_table :call_audit_detail_files do |t|
      t.integer :sequence
      t.integer :grade
      t.integer :weight
      t.string :note
      t.float :score
      t.float :possible_score
      t.references :call_audit_question, index: true
      t.integer :reference_id
      t.string :reference_type

      t.timestamps
    end
  end
end
