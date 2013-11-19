require 'spec_helper'

describe ClaimAwaitingAudit do
  it "can be instantiated" do
    ClaimAwaitingAudit.new.should be_an_instance_of(ClaimAwaitingAudit)
  end
  
  let (:claim_awaiting_audit) { FactoryGirl.create(:claim_awaiting_audit) }
  it "can be saved successfully" do
    claim_awaiting_audit.should be_persisted
    ClaimAwaitingAudit.delete_all
    CarrierBranch.delete_all
    Employee.delete_all
  end
  
  let (:claim_awaiting_aud) { FactoryGirl.build(:claim_awaiting_aud) }
  it "can not be saved without employee" do
    claim_awaiting_aud.should_not be_valid
    ClaimAwaitingAudit.delete_all
    CarrierBranch.delete_all
    Employee.delete_all
  end
  
  let (:claim_awaiting_audi) { FactoryGirl.build(:claim_awaiting_audi) }
  it "can not be saved without carrier_branch" do
    claim_awaiting_aud.should_not be_valid
    ClaimAwaitingAudit.delete_all
    CarrierBranch.delete_all
    Employee.delete_all
  end
  
end