# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_monthly_audit_entry do
    reviewer_id 1
    review "2013-11-29 16:12:22"
    css_id 1
    business_unit_id 1
    calls_date "2013-11-29 16:12:22"
    calls_count 1
    total_score 1.5
    total_possible_score 1.5
    overall_score 1.5
    monthly_total_score 1.5
    monthly_total_possible_score 1.5
    monthly_overall_score 1.5
  end
end
