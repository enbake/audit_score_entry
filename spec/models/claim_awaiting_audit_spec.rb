require 'spec_helper'

describe ClaimAwaitingAudit do
  it "can be instantiated" do
    ClaimAwaitingAudit.new.should be_an_instance_of(ClaimAwaitingAudit)
  end
  
  let (:claim_awaiting_audit) { FactoryGirl.create(:claim_awaiting_audit) }
  it "can be saved successfully" do
    claim_awaiting_audit.should be_persisted
    ClaimAwaitingAudit.delete_all
  end
end