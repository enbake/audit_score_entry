require 'spec_helper'

describe "welcome" do
 
  it "should render estimator claim filter", :js => :true do
    FactoryGirl.create(:carrier_branch)
    FactoryGirl.create(:claim_awaiting_audit)
    FactoryGirl.create(:claim_audit_question)
    FactoryGirl.create(:employee)
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "2013-11-01","2013-11-01","Benjamin"
     page.should have_content "ClaimAwaitingAudits"
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
  end

    it "should return alert for validation", :js => :true do
    FactoryGirl.create(:carrier_branch)
    FactoryGirl.create(:claim_awaiting_audit)
    FactoryGirl.create(:claim_audit_question)
    FactoryGirl.create(:employee)
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "","","Benjamin"
     a = page.driver.browser.switch_to.alert
    a.text.should eq("Please fill up the dates and select estimator!")
    a.accept
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
  end

  def filter_fill_up(from_date,to_date,estimator)
    fill_in 'fromdate_estimator', with: from_date
    fill_in 'todate_estimator', with: to_date
    select estimator, :from => 'estimator'
    find("#submit_to_filter_audit").click
  end
  
end