# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_audit_detail_file do
    sequence 1
    grade 1
    weight 1
    note "MyString"
    score 1.5
    possible_score 1.5
    call_audit_question nil
    reference_id 1
    reference_type "MyString"
  end
end
