require 'spec_helper'

describe "claim_awaiting_audit" do
  
  it "should open modal box ", :js => :true do
    sign_in
    visit root_path
    find("#claim_awaiting_audit").click()
    find("#modal_csv").click()
    page.should have_content("Upload Awaiting Claims")
  end
  
end