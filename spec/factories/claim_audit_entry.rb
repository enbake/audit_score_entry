FactoryGirl.define do
  factory :claim_audit_question_before_entry,class: ClaimAuditQuestion  do
    category "Admin"
    question "Professionally Written"
    created_at Time.now
    updated_at Time.now
  end
end
FactoryGirl.define do
  factory :claim_audit_entry do
    reviewer_id "12"
    claim "123456708"
    overall_score "1000"
    admin_score "1000"
    compliance_score "1000"
    estimating_score "1000"
    leakage_amount "1000"
    created_at "01-11-2013"
    updated_at "01-11-2013"
  end
  
  factory :claim_audit_entri, :class => 'ClaimAuditEntry' do
    association :reviewer_id, :factory => :employee
    overall_score "1000"
    admin_score "1000"
    compliance_score "1000"
    estimating_score "1000"
    leakage_amount "1000"
    created_at "01-11-2013"
    updated_at "01-11-2013"
  end
  
end
