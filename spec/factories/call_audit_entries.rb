FactoryGirl.define do
  factory :call_audit_entry do
    reviewer_id "12"
    overall_score "1000"
    review Time.now
    css_id "1"
    created_at "01-11-2013" 
    call_date "01-11-2013"
    updated_at "01-11-2013"
  end
end
