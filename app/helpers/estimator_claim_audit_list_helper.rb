module EstimatorClaimAuditListHelper

	def estimitor_find(employee_id)
		if !employee_id.blank?
			employee=Employee.where(:id => employee_id.to_i).first
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

	def adm_exception(entry)
		if entry
			ClaimAuditDetailFile.adm_exception(entry)
		end
	end

	def com_exception(entry)
		if entry
			ClaimAuditDetailFile.com_exception(entry)
		end
	end

	def over(entry)
		ClaimAuditDetailFile.over(entry)
	end

	def under(entry)
		ClaimAuditDetailFile.under(entry)
	end

	def admin_comp_answer(entry)
		ClaimAuditDetailFile.adm_com_ans(entry).group_by(&:category)
	end

	def est_answer(entry)
		ClaimAuditDetailFile.est_answers(entry).group_by(&:category)
	end

	def comments(claim)
		ClaimAuditEntry.comments claim
	end

	def give_author_name(author)
		unless author.blank?
			user=Employee.find(author)
				unless user.blank?
					return "#{user.first_name} #{user.last_name}"	
				end	
			end	
		end
  def severity entries
    if entries.length > 0
      entries.collect{|entry| entry.severity.to_f }.sum.to_f/entries.length
    end
  end

  def average_time entries
    if entries.length > 0
      entries.collect{|entry| entry.duration_net.to_f }.sum.to_f/entries.length
    end
  end

end
