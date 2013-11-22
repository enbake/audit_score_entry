module CallAuditScoreEntriesHelper
	def business_unit_name(business_id)
		business_name = business_id.blank? ? "" : "#{BusinessUnit.find_by_id(business_id).name}"
	end
	def css_name(css_id)
		unless css_id.blank?
		 css=Employee.where(:id=>css_id).first
		 css_name = "#{css.first_name} #{css.last_name}"
	    end
	end
	def employee_name
		if employee_signed_in?
			claim_awaiting_audit=ClaimAwaitingAudit.find_by_employee_id(current_employee.id) 
			@emp_name="#{current_employee.first_name} #{current_employee.last_name}"
			unless claim_awaiting_audit.blank?
				@claim_awaiting_audit_id= claim_awaiting_audit.id
				@carrier_branch_id=claim_awaiting_audit.carrier_branch_id
			end
		end
	end
end
