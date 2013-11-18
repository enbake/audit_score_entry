FactoryGirl.define do
  factory :claim_awaiting_audit do
    association :carrier_branch, :factory => :carrier_branch
    association :estimator, :factory => :employee
    claim_number "123456708"
    claim_type "IV"
    estimate_date Date.today
    active true
    timestamp Time.now
    created_employee_id "1"
    created "01/11/2013"
    completed Time.now
  end
end