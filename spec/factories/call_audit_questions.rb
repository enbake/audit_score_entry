# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do 
  factory :call_audit_question do
    category "MyString"
    question "MyString"
    weight 1
  end

  factory :call_audit_question_multiple do
    after(:create) do |call_audit_question|
      FactoryGirl.create_list(:call_audit_question, 3)
    end
  end
end