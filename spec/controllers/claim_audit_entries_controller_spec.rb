require 'spec_helper'

describe ClaimAuditEntriesController do
  before(:each) do
    @claim_awaiting_audit= FactoryGirl.create(:claim_awaiting_audit)
    @claim_audit_entry=FactoryGirl.build(:claim_audit_entry,:claim_awaiting_audit_id=>@claim_awaiting_audit.id)
    ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment,:save_last_reviewed)
    @claim_audit_entry.save
    
  end

  after(:each) do
    ClaimAwaitingAudit.delete_all
    ClaimAuditEntry.delete_all
    ClaimAuditDetailFile.delete_all
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
 describe "GET 'show'" do
    login_user
    it "returns http success" do
      get 'show',{:id=>@claim_audit_entry.id}
      response.should be_success
    end
  end

  describe "GET 'new'" do
    login_user
    it "returns http success" do
      get 'new',{claim_awaiting_id: @claim_awaiting_audit.id}
      response.should redirect_to claim_audit_entry_url(@claim_audit_entry.id)
    end
  end 
  describe "GET 'edit'" do
    login_user
    it "returns http success" do
      get 'edit',{id: @claim_audit_entry.id}
      response.should be_success
    end
  end 
 describe "GET 'confirm_edit_data'" do
    login_user
    it "returns http success" do
      get 'confirm_edit_data',{id:@claim_audit_entry.id,"1"=> {"1"=>{"question"=>"Professionally Written", "answer"=>"No", "exception"=>"3", "notes"=>"test"}},"2"=>{"4"=>{"question"=>"Parts Guidelines", "answer"=>"Yes", "notes"=>"test"}},"3"=>{"7"=>{"ext_question"=>"Tax Rate Correct", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"23", "ext_notes"=>"test"}}}
      response.should be_success
    end
  end 
describe "GET 'update'" do
    login_user
    it "returns http success" do
      get 'update',{ "adm_que"=>"{\"1\":{\"question\":\"Professionally Written\",\"answer\":\"No\",\"exception\":\"3\",\"notes\":\"test\"},\"2\":{\"question\":\"Vehicle Admin Complete\",\"answer\":\"No\",\"exception\":\"3\",\"notes\":\"test\"},\"3\":{\"question\":\"Estimate Admin Complete\",\"answer\":\"No\",\"exception\":\"4\",\"notes\":\"test\"}}", "com_que"=>"{\"4\":{\"question\":\"Parts Guidelines\",\"answer\":\"Yes\",\"notes\":\"test\"},\"5\":{\"question\":\"State Guidelines\",\"answer\":\"Yes\",\"notes\":\"test\"},\"6\":{\"question\":\"Carrer Guidelines\",\"answer\":\"Yes\",\"notes\":\"test\"}}", "est_que"=>"{\"7\":{\"ext_question\":\"Tax Rate Correct\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"23\",\"ext_notes\":\"test\"},\"8\":{\"ext_question\":\"Correct Tax Structure\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"1\",\"ext_notes\":\"test\"},\"9\":{\"ext_question\":\"Labour Rate Supported\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"12\",\"ext_notes\":\"test\"},\"10\":{\"ext_question\":\"Repair Decision Accurate\",\"ext_answer\":\"Yes\",\"ext_notes\":\"test\"},\"11\":{\"ext_question\":\"Labour Hours Accurate\",\"ext_answer\":\"Yes\",\"ext_notes\":\"test\"},\"12\":{\"ext_question\":\"APU Accurate\",\"ext_answer\":\"Yes\",\"ext_notes\":\"test\"}}", "claim_audit_entry"=>{"admin_score"=>"10", "compliance_score"=>"0", "leakage_amount"=>"36", "estimating_score"=>"Inf", "overall_score"=>"10.00"}, "comment_added"=>"", "commit"=>"Confirm", "id"=> @claim_audit_entry.id}
      response.should redirect_to(root_path)
    end
  end 

  describe "GET 'confirm_data'" do
    login_user
    it "returns http success" do
      get 'confirm_data',{ "estimator"=>"1", "claim"=>"123456708", "claim_type"=>"IV", "claim_awaiting_id"=>"25", "carrier"=>"4", "estimate_date"=>"10-19-2013", "claim_audit_entry"=>{"review"=>"2013-11-18"}, "total"=>"1022.52", "duration_net"=>"20.4", "1"=>{"1"=>{"question"=>"Professionally Written", "answer"=>"No", "exception"=>"3", "notes"=>"test note"}, "2"=>{"question"=>"Vehicle Admin Complete", "answer"=>"No", "exception"=>"3", "notes"=>"test note"}, "3"=>{"question"=>"Estimate Admin Complete", "answer"=>"No", "exception"=>"2", "notes"=>"test note"}}, "2"=>{"4"=>{"question"=>"Parts Guidelines", "answer"=>"No", "exception"=>"16", "notes"=>"test note"}, "5"=>{"question"=>"State Guidelines", "answer"=>"No", "exception"=>"13", "notes"=>"test note"}, "6"=>{"question"=>"Carrer Guidelines", "answer"=>"No", "exception"=>"15", "notes"=>"test note"}}, "3"=>{"7"=>{"ext_question"=>"Tax Rate Correct", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"23", "ext_notes"=>"test note"}, "8"=>{"ext_question"=>"Correct Tax Structure", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"1", "ext_notes"=>"test note"}, "9"=>{"ext_question"=>"Labour Rate Supported", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"12", "ext_notes"=>"test note"}, "10"=>{"ext_question"=>"Repair Decision Accurate", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"32", "ext_notes"=>"test note"}, "11"=>{"ext_question"=>"Labour Hours Accurate", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"23", "ext_notes"=>"test note"}, "12"=>{"ext_question"=>"APU Accurate", "ext_answer"=>"No", "impact"=>"Over", "amount"=>"33", "ext_notes"=>"test note"}}, "set_min_amt"=>"0", "commit"=>"Update"}
      response.should be_success
    end
  end

  describe "Post 'create'" do
    login_user
    it "redirect to root path"do
      get 'create',{"claim_audit_entry"=>{"estimator"=>"1", "claim"=>"123456790", "claim_awaiting_audit_id"=>"25", "carrier_branch_id"=>"4", "estimate_date"=>"10-19-2013", "review"=>"", "severity"=>"1022.52", "admin_score"=>"8", "compliance_score"=>"44", "estimating_score"=>"12.13", "leakage_amount"=>"124", "overall_score"=>"64.13"}, "adm_que"=>"{\"1\":{\"question\":\"Professionally Written\",\"answer\":\"No\",\"exception\":\"3\",\"notes\":\"test note\"},\"2\":{\"question\":\"Vehicle Admin Complete\",\"answer\":\"No\",\"exception\":\"3\",\"notes\":\"test note\"},\"3\":{\"question\":\"Estimate Admin Complete\",\"answer\":\"No\",\"exception\":\"2\",\"notes\":\"test note\"}}", "com_que"=>"{\"4\":{\"question\":\"Parts Guidelines\",\"answer\":\"No\",\"exception\":\"16\",\"notes\":\"test note\"},\"5\":{\"question\":\"State Guidelines\",\"answer\":\"No\",\"exception\":\"13\",\"notes\":\"test note\"},\"6\":{\"question\":\"Carrer Guidelines\",\"answer\":\"No\",\"exception\":\"15\",\"notes\":\"test note\"}}", "est_que"=>"{\"7\":{\"ext_question\":\"Tax Rate Correct\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"23\",\"ext_notes\":\"test note\"},\"8\":{\"ext_question\":\"Correct Tax Structure\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"1\",\"ext_notes\":\"test note\"},\"9\":{\"ext_question\":\"Labour Rate Supported\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"12\",\"ext_notes\":\"test note\"},\"10\":{\"ext_question\":\"Repair Decision Accurate\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"32\",\"ext_notes\":\"test note\"},\"11\":{\"ext_question\":\"Labour Hours Accurate\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"23\",\"ext_notes\":\"test note\"},\"12\":{\"ext_question\":\"APU Accurate\",\"ext_answer\":\"No\",\"impact\":\"Over\",\"amount\":\"33\",\"ext_notes\":\"test note\"}}", "comment_added"=>"", "commit"=>"Confirm"}
      response.should redirect_to root_path
    end
  end

end
