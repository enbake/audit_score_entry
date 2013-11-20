require 'spec_helper'

describe ClaimAuditCommentsController do

  before(:each) do
    @claim_audit_entry=FactoryGirl.build(:claim_audit_entry)
    ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment)
    @claim_audit_entry.save
  end

  after(:each) do
    ClaimAuditEntry.delete_all
    ClaimAuditComment.delete_all
  end

  describe "POST 'comment'" do
    login_user
    it "returns http success" do
      post 'save', {:format => 'json', "comment_new_review" => "testing comment", "claim_entry_id" => @claim_audit_entry.id}
      response.status.should eq(200)
      response.body.should eq("true")
    end
  end

end
