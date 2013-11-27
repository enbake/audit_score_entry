require 'spec_helper'

describe ClaimAuditComment do
  it "can be instantiated" do
    ClaimAuditComment.new.should be_an_instance_of(ClaimAuditComment)
  end
  
  let (:claim_audit_comment) { FactoryGirl.create(:claim_audit_comment) }

  it "can be saved successfully" do
    claim_audit_comment.should be_persisted
    ClaimAuditComment.delete_all
  end

  it "Should belongs to Claim audit entry" do
    should belong_to(:claim_audit_entry)
  end

end
