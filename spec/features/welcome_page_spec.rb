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
    find(:xpath, "//tr[last()]").click
    current_path.should eq("/claim_awaiting_audits")
    
end

end