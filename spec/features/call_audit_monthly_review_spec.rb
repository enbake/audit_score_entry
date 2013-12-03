require 'spec_helper'

describe "Call Audit Monthly Review" do
  before(:each) do
    @business_unit=FactoryGirl.create(:business_unit)
    @css=FactoryGirl.create(:employee_first,:case_type=>"css")
    CallMonthlyAuditEntry.skip_callback(:save, :after, :details_add,:add_comment)
    @css_monthly=FactoryGirl.create(:call_monthly_audit_entry,:business_unit_id=>@business_unit.id,:css_id=>@css.id)
    @questions=FactoryGirl.create(:call_audit_question)
    @css_detail=FactoryGirl.create(:call_audit_detail_file,:call_audit_question_id=>@questions.id,:reference_id=>@css_monthly.id,:reference_type=>"CallMonthlyAuditEntry")
  end

  after(:each) do
    CallMonthlyAuditEntry.delete_all
    CallAuditDetailFile.delete_all
    CallAuditQuestion.delete_all
    BusinessUnit.delete_all
    Employee.delete_all
  end

  it "displays the call audit monthly review index", :js => :true do
    sign_in
    visit root_path
    find("#call_monthly_review_test").click()
    page.should have_content "Call Audit Summary Monthly Review"
  end

  it "should render css monthly audit list", :js => :true do
    sign_in
    visit root_path
    find("#call_monthly_review_test").click()
    filter_fill_up "November","2013"               
    page.should have_content "Call Score"   
  end

  it "should go to new monthly score entry form", :js => :true do
    sign_in
    visit root_path
    find("#call_monthly_review_test").click()
    filter_fill_up "November","2013"
    find(".clickable_to_test").click()
    page.should have_content "# of Calls This Month:"
  end  

  it "should go to Call Audit Entry Page", :js => :true do
    sign_in
    visit root_path
    find("#call_monthly_review_test").click()
    filter_fill_up "November","2013"
    find(".clickable_to_test").click()
    find("#call_audit_test").click()
    page.should have_content "Call Type"
  end

  def filter_fill_up(month,year)
    select month, :from => 'date_month'
    select year, :from => 'date_year'
    find("#search_call_monthly").click()
  end
end