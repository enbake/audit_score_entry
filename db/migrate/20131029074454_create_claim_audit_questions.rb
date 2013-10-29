class CreateClaimAuditQuestions < ActiveRecord::Migration
  def change
    create_table :claim_audit_questions do |t|
      t.string :category
      t.text :question
      t.string :response
      t.decimal :min_exception
      t.decimal :max_exception

      t.timestamps
    end
  end
end
