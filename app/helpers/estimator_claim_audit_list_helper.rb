module EstimatorClaimAuditListHelper
	def estimitor_find(employee_id)
		if !employee_id.blank?
			employee=Employee.where(:id=>employee_id.to_i).first
			if !employee.blank?
				return "#{employee.first_name} #{employee.last_name}"
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
end
