module EstimatorClaimAuditListHelper
	def estimitor_find(employee_id)
		if !employee_id.blank?
			employee=Employee.where(:id=>employee_id).first
			if !employee.blank?
				return "#{employee.first_name} #{employee.last_name}"
			end	
		end
	end
	def admin_score_find(claim_number,claim_type)
		if !claim_number.blank? and !claim_type.blank?
			claim_audit_entry=ClaimAuditEntry.where(:claim=>"#{claim_number} #{claim_type}").first
			if !claim_audit_entry.blank?
				return "#{claim_audit_entry.admin_score}"
			end	
		end
	end
	def compliance_score_find(claim_number,claim_type)
		if !claim_number.blank? and !claim_type.blank?
			claim_audit_entry=ClaimAuditEntry.where(:claim=>"#{claim_number} #{claim_type}").first
			if !claim_audit_entry.blank?
				return "#{claim_audit_entry.compliance_score}"
			end	
		end
	end
	def estimating_score_find(claim_number,claim_type)
		if !claim_number.blank? and !claim_type.blank?
			claim_audit_entry=ClaimAuditEntry.where(:claim=>"#{claim_number} #{claim_type}").first
			if !claim_audit_entry.blank?
				return "#{claim_audit_entry.estimating_score}"
			end	
		end
	end
	def overall_score_find(claim_number,claim_type)
		if !claim_number.blank? and !claim_type.blank?
			claim_audit_entry=ClaimAuditEntry.where(:claim=>"#{claim_number} #{claim_type}").first
			if !claim_audit_entry.blank?
				return "#{claim_audit_entry.overall_score}"
			end	
		end
	end
	def leakage_amount_find(claim_number,claim_type)
		if !claim_number.blank? and !claim_type.blank?
			claim_audit_entry=ClaimAuditEntry.where(:claim=>"#{claim_number} #{claim_type}").first
			if !claim_audit_entry.blank?
				return "#{claim_audit_entry.leakage_amount}"
			end	
		end
	end
end
