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
  EmployeeMaster.delete_all
 end

 it "should render estimator claim filter", :js => :true do
    sign_in
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "01-11-2013","01-11-2013","Benjamin"
    page.should have_content "Claim Audit Entry"
 end

it "should return alert for validation", :js => :true do
    sign_in
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "","","Benjamin"
    a = page.driver.browser.switch_to.alert
    a.text.should eq("Please fill up the dates and select estimator!")
    a.accept
end

def filter_fill_up(from_date,to_date,estimator)
    fill_in 'fromdate_estimator', with: from_date
    fill_in 'todate_estimator', with: to_date
    select estimator, :from => 'estimator'
    find("#submit_to_filter_audit").click
end

end