require 'spec_helper'

describe CallAuditMonthlyReviewController do
  before(:each) do
    CallMonthlyAuditEntry.skip_callback(:save, :after, :details_add,:add_comment)
    @call_audit_monthly_entry=FactoryGirl.create(:call_monthly_audit_entry)
  end

  after(:each) do
    CallMonthlyAuditEntry.delete_all
    Employee.delete_all
  end
  describe "GET 'index'" do
    login_user
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'search'" do
    login_user
    it "returns ajax success" do
      xhr :post, :search,{:date=>{:month=>"11",:year=>"2013"}}
      response.code.should == "200"
    end
  end

end
