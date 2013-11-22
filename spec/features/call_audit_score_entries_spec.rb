require 'spec_helper'

describe "welcome" do
  before(:each) do
     FactoryGirl.create(:business_unit)
 end

 after(:each) do
    BusinessUnit.delete_all
    Employee.delete_all
end
it "displays the call audit entry index", :js => :true do
    sign_in
    visit root_path
    find("#main_call_audit_index").click()
    page.should have_content "New Call Audit Score Entry"
    
end

it "should render new call audit score entry page", :js => :true do
    sign_in
    visit root_path
    find("#main_call_audit_index").click()
    filter_fill_up "Archies","Benjamin","22-11-2013"
    page.should have_content "Call Length:"   

end
def filter_fill_up(business_unit,css,call_date)
    fill_in 'call_time', with: call_date
    select business_unit, :from => 'business_unit'
    select css, :from => 'css'
    find("#new_call_audit").click
end

end