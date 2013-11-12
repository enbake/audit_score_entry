require 'spec_helper'

describe ClaimAuditComment do
	it "can be instantiated" do
		ClaimAuditComment.new.should be_an_instance_of(ClaimAuditComment)
	end

	ClaimAuditEntry.skip_callback(:save, :after, :question_details)
	let (:claim_audit_entry) { FactoryGirl.create(:claim_audit_entry) }
	it "can be saved successfully" do
		claim_audit_entry.should be_persisted
	end
end