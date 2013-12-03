require 'spec_helper'

describe CallAuditEntry do
	it "can be instantiated" do
		CallAuditEntry.new.should be_an_instance_of(CallAuditEntry)
	end

	CallAuditEntry.skip_callback(:save, :after, :details_add,:add_comment,:add_business_unit)
	let (:call_audit_entry) { FactoryGirl.create(:call_audit_entry) }
	it "can be saved successfully" do
		call_audit_entry.should be_persisted
		CallAuditEntry.delete_all
  end
end