# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call_audit_question do
    category "MyString"
    sequence 1
    question "MyString"
    weight 1
  end
end
