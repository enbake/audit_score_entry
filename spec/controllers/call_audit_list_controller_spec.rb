require 'spec_helper'

describe CallAuditListController do

  before(:each) do
    @call_audit_entry=FactoryGirl.build(:call_audit_entry)
    CallAuditEntry.skip_callback(:save, :after, :details_add,:add_comment,:add_business_unit)
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
  describe "POST 'search'" do
    login_user
    it "returns http success" do
      post 'search',{:css=>"1",:call=>{"date(2i)"=>"11","date(1i)"=>"2013"}}
      response.should be_success
    end
  end

end
