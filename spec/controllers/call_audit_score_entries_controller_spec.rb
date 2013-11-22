require 'spec_helper'

describe CallAuditScoreEntriesController do

  before(:each) do
    @call_audit_entry=FactoryGirl.build(:call_audit_entry)
    CallAuditEntry.skip_callback(:save, :after, :details_add,:add_comment)
    @call_audit_entry.save
  end

  after(:each) do
    CallAuditEntry.delete_all
    CallAuditDetailFile.delete_all
    ClaimAuditComment.delete_all
    Employee.delete_all
  end

  describe "GET 'index'" do
    login_user
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    login_user
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end 

  describe "GET 'confirm_data'" do
    login_user
    it "returns http success" do
      get 'confirm_data',{"business_unit"=>"8", "call_audit_score_entry"=>{"css_id"=>"5", "call_date"=>"22-11-2013", "review"=>"2013-11-22 17:42:43 +0530", "call_type"=>"Verify options", "call_length"=>"44 sec"}, "1"=>{"1"=>{"question"=>"Introduction", "grade"=>"4", "notes"=>"", "weight"=>"1", "sequence"=>"1"}, "2"=>{"question"=>"Description of Process", "grade"=>"5", "notes"=>"", "weight"=>"2", "sequence"=>"2"}, "3"=>{"question"=>"Call to Action", "grade"=>"4", "notes"=>"", "weight"=>"3", "sequence"=>"3"}, "4"=>{"question"=>"General Demeanor", "grade"=>"5", "notes"=>"", "weight"=>"4", "sequence"=>"4"}, "5"=>{"question"=>"Addressing Concerns", "grade"=>"5", "notes"=>"", "weight"=>"5", "sequence"=>"5"}}, "commit"=>"Next"}
      response.should be_success
    end
  end

  describe "Post 'create'" do
    login_user
    it "redirect to root path"do
    get 'create',{"answer_fields"=>"{\"1\":{\"question\":\"Introduction\",\"grade\":\"4\",\"notes\":\"\",\"weight\":\"1\",\"sequence\":\"1\"},\"2\":{\"question\":\"Description of Process\",\"grade\":\"5\",\"notes\":\"\",\"weight\":\"2\",\"sequence\":\"2\"},\"3\":{\"question\":\"Call to Action\",\"grade\":\"4\",\"notes\":\"\",\"weight\":\"3\",\"sequence\":\"3\"},\"4\":{\"question\":\"General Demeanor\",\"grade\":\"5\",\"notes\":\"\",\"weight\":\"4\",\"sequence\":\"4\"},\"5\":{\"question\":\"Addressing Concerns\",\"grade\":\"5\",\"notes\":\"\",\"weight\":\"5\",\"sequence\":\"5\"}}", "business_unit"=>"8", "call_audit_score_entry"=>{"css_id"=>"5", "call_date"=>"22-11-2013", "reviewer_id"=>"5", "claim_awaiting_audit_id"=>"1", "carrier_branch_id"=>"1", "review"=>"2013-11-22 17:42:43 +0530", "call_type"=>"Verify options", "call_length"=>"44 sec", "total_score"=>"71", "total_possible_score"=>"75", "overall_score"=>"92"}, "comment"=>"troll", "commit"=>"Update"}
    response.should redirect_to root_path
  end
end

end
