require 'spec_helper'

describe "welcome" do
  it "displays the claim Awaiting Audits list", :js => :true do
    FactoryGirl.create(:carrier_branch)
    FactoryGirl.create(:claim_awaiting_audit)
    visit root_path
    page.should have_content "Claim No."
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
  end
  
  it "should render new claim audit entry page", :js => :true do
    FactoryGirl.create(:carrier_branch)
    FactoryGirl.create(:claim_awaiting_audit)
    FactoryGirl.create(:claim_audit_question)
    visit root_path
    find(:xpath, "//tr[last()]").click
    current_path.should eq("/claim_audit_entries/new")
    find("#hd_ad").click
    a = page.driver.browser.switch_to.alert
    a.text.should eq("Please fill the focused field")
    a.accept
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
  end
  
end