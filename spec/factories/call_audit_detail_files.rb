# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_audit_detail_file do
    grade "1"
    weight "1"
    note "test comment"
    score "1.5"
    possible_score "1.5"
    call_audit_question_id "1"
    reference_id "1"
    reference_type "MyString"
  end
end
