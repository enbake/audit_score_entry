class ChangingReferenceFieldForUnsavedAudits < ActiveRecord::Migration
  def change
    add_reference :unsaved_awaiting_audits, :creator_employee, index: true
    remove_reference :unsaved_awaiting_audits, :employee_master
  end
end
