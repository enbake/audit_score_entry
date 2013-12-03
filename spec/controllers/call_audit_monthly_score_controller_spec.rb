require 'spec_helper'

describe CallAuditMonthlyScoreController do

  before(:each) do
    @employee_first=FactoryGirl.create(:employee_first)
    @call_audit_monthly_entry=FactoryGirl.build(:call_monthly_audit_entry,:css_id=>@employee_first.id)
    CallMonthlyAuditEntry.skip_callback(:save, :after, :details_add,:add_comment)
    @call_audit_monthly_entry.save
  end

  after(:each) do
    CallMonthlyAuditEntry.delete_all
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
  describe "GET 'show'" do
    login_user
    it "returns http success" do
      get 'show',{:id=>@call_audit_monthly_entry.id}
      response.should be_success
    end
  end
  describe "POST 'search'" do
    login_user
    it "returns ajax success" do
      xhr :post, :search,{:date=>{:month=>"11",:year=>"2013"},:business_unit=>@employee_first.id}
      response.code.should == "200"
    end
  end


  describe "GET 'new'" do
    login_user
    it "returns http success" do
      get 'new',{:css_id=>@employee_first.id}
      response.should be_success
    end
  end 
  describe "GET 'edit'" do
    login_user
    it "returns http success" do
      get 'edit',{:id=>@call_audit_monthly_entry.id}
      response.should be_success
    end
  end 
  describe "GET 'destroy'" do
    login_user
    it "returns http success" do
      get 'destroy',{:id=>@call_audit_monthly_entry.id}
      response.should redirect_to call_audit_monthly_score_index_path
    end
  end 

  describe "GET 'confirm'" do
    login_user
    it "returns http success" do
      get 'confirm',{"call_audit_month"=>{"css_id"=>"11", "call_date"=>"2013-12-02 16:55:21 +0530", "calls_count"=>["34"]}, "business_unit_id"=>"1", "1"=>{"1"=>{"question"=>"Competency", "grade"=>"5", "notes"=>"test", "weight"=>"1", "sequence"=>"1"}, "2"=>{"question"=>"Attendance/Punctuality", "grade"=>"5", "notes"=>"test", "weight"=>"2", "sequence"=>"2"}, "3"=>{"question"=>"Initiative", "grade"=>"5", "notes"=>"test", "weight"=>"3", "sequence"=>"3"}, "4"=>{"question"=>"Communication Skills", "grade"=>"5", "notes"=>"test", "weight"=>"4", "sequence"=>"4"}, "5"=>{"question"=>"Reliability", "grade"=>"5", "notes"=>"test", "weight"=>"5", "sequence"=>"5"}}, "commit"=>"Next"}
      response.should be_success
    end
  end

  describe "Post 'create'" do
    login_user
    it "redirect to root path"do
    get 'create',{"answer_fields"=>"{\"1\":{\"question\":\"Competency\",\"grade\":\"5\",\"notes\":\"test\",\"weight\":\"1\",\"sequence\":\"1\"},\"2\":{\"question\":\"Attendance/Punctuality\",\"grade\":\"5\",\"notes\":\"test\",\"weight\":\"2\",\"sequence\":\"2\"},\"3\":{\"question\":\"Initiative\",\"grade\":\"5\",\"notes\":\"test\",\"weight\":\"3\",\"sequence\":\"3\"},\"4\":{\"question\":\"Communication Skills\",\"grade\":\"5\",\"notes\":\"test\",\"weight\":\"4\",\"sequence\":\"4\"},\"5\":{\"question\":\"Reliability\",\"grade\":\"5\",\"notes\":\"test\",\"weight\":\"5\",\"sequence\":\"5\"}}", "call_audit_monthly_score_entry"=>{"css_id"=>"11", "reviewer_id"=>"11", "business_unit_id"=>"1", "calls_date"=>"2013-12-02T16:55:21+05:30", "review"=>"2013-12-02 16:55:52 +0530", "calls_count"=>"34", "monthly_total_score"=>"75", "monthly_total_possible_score"=>"75", "monthly_overall_score"=>"100"}, "comment"=>"test 1 comment", "strengths"=>"test 2 comment", "development_needs"=>"test 3 comment", "commit"=>"Continue"}
    response.should redirect_to root_path
  end
end

end