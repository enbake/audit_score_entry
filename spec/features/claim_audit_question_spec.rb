require 'spec_helper'

describe "welcome" do
 before(:each) do
   FactoryGirl.create(:claim_audit_question)
end

after(:each) do
    ClaimAuditQuestion.delete_all
    Employee.delete_all
end

it "displays the claim Audit Questions list", :js => :true do
    sign_in_as_admin
    visit root_path
    find("#claim_audit_question_btn").click()
    page.should have_content "Admin"
end

it "should render new claim question entry page", :js => :true do
    sign_in_as_admin
    visit root_path
    find("#claim_audit_question_btn").click()
    find("#new_ques").click()
    select 'Admin', :from => 'que_sel'
    fill_in 'claim_audit_question_question', with: 'test question?'
    fill_in 'claim_audit_question_min_exception', with: '1'
    fill_in 'claim_audit_question_max_exception', with: '10'
    find("#save_ques").click
    page.should have_content "Question has been successfully added."
end
end