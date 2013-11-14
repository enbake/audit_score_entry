require 'spec_helper'

describe ClaimAuditDetailFile do
  let (:claim_audit_detail_file) { FactoryGirl.build(:claim_audit_detail_file) }
  it "should not store records for admin" do
    claim_audit_detail_file.should_not be_valid
  end
  
  let (:claim_audit_detail) { FactoryGirl.build(:claim_audit_detail) }
  it "should not store records for compliance" do
    claim_audit_detail.should_not be_valid
  end
  
  let (:claim_audit_file) { FactoryGirl.build(:claim_audit_file) }
  it "should not store records for estimation" do
    claim_audit_file.should_not be_valid
  end
end