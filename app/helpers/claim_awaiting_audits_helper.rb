module ClaimAwaitingAuditsHelper
	def find_branch_name(claim_awaiting_audit_branch_id)
		carrier_branch=CarrierBranch.where(:id=>claim_awaiting_audit_branch_id).first
		if !carrier_branch.blank?
			return carrier_branch.name	
		else
			return nil
		end
	end	
end
