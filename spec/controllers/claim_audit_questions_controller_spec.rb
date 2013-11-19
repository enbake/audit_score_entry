require 'spec_helper'

describe ClaimAuditQuestionsController do

  describe "GET 'index'" do
    login_user  
      it "returns http success" do
        get 'index'
        response.should be_success
        Employee.delete_all
      end
  end

  describe "GET 'new'" do
    login_user 
      it "returns http success" do
        get 'new'
        response.should be_success
        Employee.delete_all
      end
  end 
  describe "Post 'create'" do
    login_user
      it "redirect to index" do
        get 'create',{"claim_audit_question"=>{"category"=>"Admin", "question"=>"Test question?", "min_exception"=>"12", "max_exception"=>"100", "min_amount"=>"0"}, "commit"=>"Save"}
        response.should redirect_to claim_audit_questions_path
        Employee.delete_all
        ClaimAuditQuestion.delete_all
      end
  end

end
