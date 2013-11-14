require 'spec_helper'

describe ClaimAuditEntry do
	it "can be instantiated" do
		ClaimAuditEntry.new.should be_an_instance_of(ClaimAuditEntry)
	end

	ClaimAuditEntry.skip_callback(:save, :after, :question_details)
	let (:claim_audit_entry) { FactoryGirl.create(:claim_audit_entry) }
	it "can be saved successfully" do
		claim_audit_entry.should be_persisted
		ClaimAuditEntry.delete_all
	end
end