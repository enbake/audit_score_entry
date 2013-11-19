require 'spec_helper'

describe "welcome" do
  before(:each) do
    @estimator=FactoryGirl.create(:employee)
    @claim_audit_entry=FactoryGirl.build(:claim_audit_entry,:estimator=>@estimator.id)
    ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment)
    @claim_audit_entry.save
  end

  after(:each) do
    ClaimAuditEntry.delete_all
    CarrierBranch.delete_all
    Employee.delete_all
    Employee.delete_all
  end
  
  it "displays the claim Awaiting Audits list", :js => :true do
    sign_in
    visit root_path
    page.should have_content "Estimator Claims List"
  end

  it "should render estimator claim filter", :js => :true do
    sign_in
    visit root_path
    find("#Main_claim_audit_list").click
    page.should have_content "Time period:" 
  end

end