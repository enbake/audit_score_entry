require 'spec_helper'

describe "welcome" do
 before(:each) do
  @estimator=FactoryGirl.create(:employee_first)
  ClaimAuditEntry.skip_callback(:save, :after, :question_details,:add_comment,:save_last_reviewed)
  @claim_awaiting_audit=FactoryGirl.create(:claim_awaiting_audit)
  @carrier_branch=FactoryGirl.create(:carrier_branch)
  @claim_audit_entry=FactoryGirl.create(:claim_audit_entry,:estimator=>@estimator.id,:claim_awaiting_audit_id=>@claim_awaiting_audit.id,:carrier_branch_id=>@carrier_branch.id,:reviewer_id=>@estimator.id)

 end

 after(:each) do
  ClaimAuditEntry.delete_all
  ClaimAwaitingAudit.delete_all
  CarrierBranch.delete_all
  Employee.delete_all
 end

 it "should render edit claim audit entry", :js => :true do
    sign_in
    visit root_path
    find("#Main_claim_audit_list").click
    filter_fill_up "1-11-2013","1-11-2013","Ben"
    find(".to_click_in_test").click
    find("#open_edit_page").click
    page.should have_content "Edit Claim Audit Entry"
 end


def filter_fill_up(from_date,to_date,estimator)
    fill_in 'fromdate_estimator', with: from_date
    fill_in 'todate_estimator', with: to_date
    select estimator, :from => 'estimator'
    find("#submit_to_filter").click
end

end