require 'spec_helper'

describe "welcome" do
 before(:each) do
  @estimator=FactoryGirl.create(:employee_first)
  @carrier_branch=FactoryGirl.create(:carrier_branch)
  @claim_awaiting_audit=FactoryGirl.create(:claim_awaiting_audit)
  @claim_audit_entry=FactoryGirl.build(:claim_audit_entry,:estimator=>@estimator.id,:claim_awaiting_audit_id=>@claim_awaiting_audit.id,:carrier_branch_id=>@carrier_branch.id)
  ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment)
  @claim_audit_entry.save
 end

 after(:each) do
  ClaimAuditEntry.delete_all
  ClaimAwaitingAudit.delete_all
  CarrierBranch.delete_all
  Employee.delete_all
 end

 it "should render estimator claim filter", :js => :true do
    sign_in
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "01-11-2013","01-11-2013","Ben"
    page.should have_content "Claim Audit Entry"
 end

it "should return alert for validation", :js => :true do
    sign_in
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "","","Ben"
     current_path.should eq("/estimator_claim_audit_list/index")
end

def filter_fill_up(from_date,to_date,estimator)
    fill_in 'fromdate_estimator', with: from_date
    fill_in 'todate_estimator', with: to_date
    select estimator, :from => 'estimator'
    find("#submit_to_filter").click
end

end