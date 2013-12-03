require 'spec_helper'

describe "welcome" do
  before(:each) do
     @business_unit=FactoryGirl.create(:business_unit)
     @css_id= FactoryGirl.create(:employee_first,:case_type=>"css",:business_unit_id=>@business_unit.id)
     CallAuditEntry.skip_callback(:save, :after, :details_add,:add_comment,:add_business_unit)
     @call_entry=FactoryGirl.create(:call_audit_entry,:css_id=>@css_id.id,:reviewer_id=>@css_id.id)
     @call_question=FactoryGirl.create(:call_audit_question)
     FactoryGirl.create(:call_audit_detail_file,:call_audit_question_id=>@call_question.id,:reference_id=>@call_entry.id,:reference_type=>"CallAuditEntry")


 end

 after(:each) do
    BusinessUnit.delete_all
    Employee.delete_all
    CallAuditEntry.delete_all
    CallAuditDetailFile.delete_all
    CallAuditQuestion.delete_all
end
it "displays the call audit entry list", :js => :true do
    sign_in
    visit root_path
    find("#main_call_audit_list").click()
    filter_fill_up "November",@css_id.first_name,"2013"
    page.should have_content "Ben Hall"
    
end

it "should render edit call audit score entry page", :js => :true do
    sign_in
    visit root_path
    find("#main_call_audit_list").click()
    filter_fill_up "November",@css_id.first_name,"2013"
    find(".open_call_for_entry").click
    page.should have_content "Call Audit Review"   

end
def filter_fill_up(month,css,year)
    select month, :from => 'call_date_2i'
    select year, :from => 'call_date_1i'
    select css, :from => 'css'
    find("#submit_to_get_call_list").click
end

end