require 'spec_helper'

describe CallAuditDetailFile do
	it "can be instantiated" do
		CallAuditDetailFile.new.should be_an_instance_of(CallAuditDetailFile)
	end
	
	let (:call_audit_detail_file) { FactoryGirl.create(:call_audit_detail_file) }
	it "can be saved successfully" do
		call_audit_detail_file.should be_persisted
		CallAuditDetailFile.delete_all
  end
end