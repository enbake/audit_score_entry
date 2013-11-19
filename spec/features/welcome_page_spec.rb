require 'spec_helper'

describe "welcome" do
  before(:each) do
   FactoryGirl.create(:claim_awaiting_audit)
   FactoryGirl.create(:claim_audit_question)
end

after(:each) do
    ClaimAuditQuestion.delete_all
    CarrierBranch.delete_all
    ClaimAwaitingAudit.delete_all
    Employee.delete_all
    Employee.delete_all
end
it "displays the claim Awaiting Audits list", :js => :true do
    sign_in
    visit root_path
    find("#claim_awaiting_audit").click()
    page.should have_content "Claim#"
    
end

it "should render new claim audit entry page", :js => :true do
    sign_in
    visit root_path
    find("#claim_awaiting_audit").click()
    find(:xpath, "//tr[last()]").click
    current_path.should eq("/claim_audit_entries/new")
    find("#hd_ad").click
    a = page.driver.browser.switch_to.alert
    a.text.should eq("Please fill the focused field")
    a.accept
    
end

end