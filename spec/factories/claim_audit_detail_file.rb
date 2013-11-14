FactoryGirl.define do 
  factory :claim_audit_detail_file do
    category "Admin"
    answer "No"
  end
  
  factory :claim_audit_detail, class: ClaimAuditDetailFile do
    category "Compliance"
    answer "No"
  end
  
  factory :claim_audit_file, class: ClaimAuditDetailFile do
    category "Estimation Decisions"
    answer "No"
  end
end