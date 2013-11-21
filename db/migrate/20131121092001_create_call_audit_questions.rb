class CreateCallAuditQuestions < ActiveRecord::Migration
  def change
    create_table :call_audit_questions do |t|
      t.string :category
      t.integer :sequence
      t.string :question
      t.integer :weight

      t.timestamps
    end
  end
end
