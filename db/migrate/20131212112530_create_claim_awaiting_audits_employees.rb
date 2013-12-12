class CreateClaimAwaitingAuditsEmployees < ActiveRecord::Migration
  def change
    create_table :claim_awaiting_audits_employees, :id => false do |t|
      t.references :claim_awaiting_audit, :employee
    end
  end
end
