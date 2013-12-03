require 'spec_helper'

describe CallMonthlyAuditEntry do
	it "can be instantiated" do
		CallMonthlyAuditEntry.new.should be_an_instance_of(CallMonthlyAuditEntry)
	end

	CallMonthlyAuditEntry.skip_callback(:save, :after, :details_add,:add_comment)
	let (:call_monthly_audit_entry) { FactoryGirl.create(:call_monthly_audit_entry) }
	it "can be saved successfully" do
		call_monthly_audit_entry.should be_persisted
		CallMonthlyAuditEntry.delete_all
	end
end