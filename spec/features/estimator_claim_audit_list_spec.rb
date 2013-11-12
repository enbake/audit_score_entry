require 'spec_helper'

describe "welcome" do
  it "displays the claim Awaiting Audits list", :js => :true do
    FactoryGirl.create(:carrier_branch)
    FactoryGirl.create(:claim_awaiting_audit)
    visit root_path
    page.should have_content "Estimator Claims Audit List"
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
  end
  
  it "should render estimator claim filter", :js => :true do
    FactoryGirl.create(:carrier_branch)
    FactoryGirl.create(:claim_awaiting_audit)
    FactoryGirl.create(:claim_audit_question)
    visit root_path
    find("#Main_claim_audit_list").click
    page.should have_content "Time period:" 
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
  end
  
end