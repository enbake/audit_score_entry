module EstimatorClaimAuditListHelper
	def estimitor_find(employee_id)
		if !employee_id.blank?
			employee=Employee.where(:id=>employee_id.to_i).first
			if !employee.blank?
				return "#{employee.first_name} #{employee.last_name}"
			end	
		end
	end
	def estimate_date(claim_id)
		if !claim_id.blank?
			awaiting=ClaimAwaitingAudit.where(:claim_number=>claim_id.to_i).first
			if !awaiting.blank?
				@estimate_date= "#{awaiting.estimate_date}"
				@claim_type="#{awaiting.claim_type}"
			end	
		end
    end
	def carrier_name_find(carrier_id)
		if !carrier_id.blank?
			carrier=CarrierBranch.where(:id=>carrier_id.to_i).first
			if !carrier.blank?
				return "#{carrier.name}"
			end	
		end
	end
	def entry_scores_find(claim_number)
		if !claim_number.blank?
			claim_audit_entry=ClaimAuditEntry.where(:claim=>claim_number).first
			if !claim_audit_entry.blank?
				@claim_admin_score= "#{claim_audit_entry.admin_score}"
				@claim_compliance_score="#{claim_audit_entry.compliance_score}"
				@claim_estimating_score= "#{claim_audit_entry.estimating_score}"
				@claim_overall_score="#{claim_audit_entry.overall_score}"
				@claim_leakage_amount="#{claim_audit_entry.leakage_amount}"
			end	
		end
	end
end
