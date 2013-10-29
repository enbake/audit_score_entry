json.array!(@claim_audit_entries) do |claim_audit_entry|
  json.extract! claim_audit_entry, :reviewer, :review, :claim, :estimator, :overall_score, :admin_score, :compliance_score, :estimating_score, :leakage_amount
  json.url claim_audit_entry_url(claim_audit_entry, format: :json)
end
