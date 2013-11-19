# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unsaved_awaiting_audit do
    association :employee_id, :factory => :employee
    claim_number "MyString"
    claim_type "MyString"
    carrier_branch_id 1
    severity "9.99"
    duration_net "9.99"
    estimate_date "2013-11-13"
    active false
    created_employee_id 1
    completed "2013-11-13 13:12:04"
    completed_employee_id 1
  end
end
