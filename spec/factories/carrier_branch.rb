FactoryGirl.define do 
  factory :carrier_branch do
    #association :claim_awaiting_audits, :factory => :claim_awaiting_audit
    carrier_id 1
    name "Farmers"
    timestamp Time.now
  end
end