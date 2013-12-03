require 'spec_helper'

describe "welcome" do
  before(:each) do
     @b_unit= FactoryGirl.create(:business_unit)
     FactoryGirl.create(:employee_first,:case_type=>"css",:business_unit_id=>@b_unit.id)
  end

 after(:each) do
    BusinessUnit.delete_all
    Employee.delete_all
 end

it "displays the call audit monthly score entry index", :js => :true do
    sign_in
    visit root_path
    find("#call_audit_monthly_score").click()
    page.should have_content "Call Audit Monthly Score Entry"
end

it "should render css monthly score list", :js => :true do
    sign_in
    visit root_path
    find("#call_audit_monthly_score").click()
    filter_fill_up @b_unit.name,"December","2013"
    page.should have_content "Last Month Entry"   
end

it "should go to new monthly score entry form", :js => :true do
    sign_in
    visit root_path
    find("#call_audit_monthly_score").click()
    filter_fill_up @b_unit.name,"December","2013"
    find(".clickable_to_test").click
    page.should have_content "of Calls This Month:"
end

def filter_fill_up(business_unit,month,year)
    select business_unit, :from => 'business_unit'
    select month, :from => 'date_month'
    select year, :from => 'date_year'
    find("#submit_to_search").click
end

end