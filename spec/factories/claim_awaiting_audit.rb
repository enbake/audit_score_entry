FactoryGirl.define do
  factory :claim_awaiting_audit do
    association :carrier_branch, :factory => :carrier_branch
    claim_number "123456708"
    claim_type "IV"
    loss Date.today
    active true
    timestamp Time.now
  end
end