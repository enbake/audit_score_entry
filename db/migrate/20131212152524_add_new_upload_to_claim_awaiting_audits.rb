class AddNewUploadToClaimAwaitingAudits < ActiveRecord::Migration
  def change
    add_column :claim_awaiting_audit, :new_upload, :boolean, :default => true
  end
end
