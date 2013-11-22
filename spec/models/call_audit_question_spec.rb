require 'spec_helper'

describe CallAuditQuestion do
	it "can be instantiated" do
		CallAuditQuestion.new.should be_an_instance_of(CallAuditQuestion)
	end
	
	let (:call_audit_question) { FactoryGirl.create(:call_audit_question) }
	it "can be saved successfully" do
		call_audit_question.should be_persisted
		CallAuditQuestion.delete_all
  end
end