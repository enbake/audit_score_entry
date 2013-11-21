# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_audit_entry do
    reviewer_id 1
    review "2013-11-21 17:24:08"
    css_id 1
    call_type "MyString"
    call_length "MyString"
    call_date "2013-11-21 17:24:08"
    call_file_url "MyString"
    total_score 1.5
    total_possible_score 1.5
    overall_score 1.5
    claim_awaiting_audit nil
    carrier_branch nil
  end
end
