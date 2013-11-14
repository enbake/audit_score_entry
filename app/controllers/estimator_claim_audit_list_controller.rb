class EstimatorClaimAuditListController < ApplicationController
	# Estimator review index page
	def index
		@claim_awaiting_audits = ClaimAwaitingAudit.all
		@carrier_branch=CarrierBranch.all
		@claim_estimator=Employee.all
	end
	# Estimator review filter page
	def filtered_list  
		@above_var_list=Hash.new
		if !params[:from_date].blank? and !params[:to_date].blank? and !params[:estimator_id].blank?
			if !params[:carrier_id].blank?
				@claim_audit_entry=ClaimAuditEntry.select("*").where("carrier_branch_id=? and estimator=? and DATE(created_at) between ? and ?",params[:carrier_id],"#{params[:estimator_id]}",
					Date.parse("#{params[:from_date]}"),Date.parse("#{params[:to_date]}")).joins(:claim_awaiting_audit)
			else
				@claim_audit_entry=ClaimAuditEntry.select("*").where("estimator=? and DATE(created_at) between ? and ?","#{params[:estimator_id]}",
					Date.parse("#{params[:from_date]}"),Date.parse("#{params[:to_date]}")).joins(:claim_awaiting_audit)
			end	
			@above_var_list[:count]=@claim_audit_entry.count
			@above_var_list[:from_date]=params[:from_date]
			@above_var_list[:to_date]=params[:to_date]
			estimator_name=Employee.where(:id=>params[:estimator_id]).first
			@above_var_list[:estimator]="#{estimator_name.first_name} #{estimator_name.last_name}"
			carrier=CarrierBranch.where(:id=>params[:carrier_id]).first
			if !carrier.nil?
				@above_var_list[:carrier]="#{carrier.name}"
			end
			@above_var_list[:severity]=@claim_audit_entry.collect{|entry|  entry.severity.to_f }.sum.to_f/@claim_audit_entry.length if @claim_audit_entry.length > 0
			@above_var_list[:average_time]=@claim_audit_entry.collect{|entry|  entry.duration_net.to_f }.sum.to_f/@claim_audit_entry.length if @claim_audit_entry.length > 0
		end
	end	
	# Show filtered claim audit entries
	def show_saved_audit_estimate
		@claim = "#{params[:c_num]}"
		@claim_type="#{params[:c_type]}"
		@carrier = params[:carrier]
		@estimate_date = "#{Date.parse(params[:estimate_date]).strftime('%m/%d/%Y')}"
		@total = params[:total]	
		@duration_net=params[:duration_net]	
		@claim_audit_entry = ClaimAuditEntry.where(:claim=>@claim).first  
		admin_estimate_question_headers
		if !@claim_audit_entry.blank?
			find_reviewer_and_estimator(@claim_audit_entry.reviewer_id,@claim_audit_entry.estimator)
			@claim_audit_details=ClaimAuditDetailFile.where(:claim_audit_entry_id=>@claim_audit_entry.id)
			@adm_exception = ClaimAuditDetailFile.where("claim_audit_entry_id=? and category=?",@claim_audit_entry.id,"Admin").collect{|entry|  entry.exception.to_f }.sum
			@com_exp = ClaimAuditDetailFile.where("claim_audit_entry_id=? and category=?",@claim_audit_entry.id,"Compliance").collect{|entry|  entry.exception.to_f }.sum
			@over = ClaimAuditDetailFile.where("claim_audit_entry_id=? and indicator=?",@claim_audit_entry.id,"Over").collect{|entry|  entry.amount.to_f }.sum
			@under =ClaimAuditDetailFile.where("claim_audit_entry_id=? and indicator=?",@claim_audit_entry.id,"Under").collect{|entry|  entry.amount.to_f }.sum
			@admin_comp_answer = ClaimAuditDetailFile.where("claim_audit_entry_id=? and (category=? or category=?)",@claim_audit_entry.id,"Admin","Compliance").group_by(&:category)
			@est_answer = ClaimAuditDetailFile.where(:claim_audit_entry_id=>@claim_audit_entry.id,:category=>"Estimation Decisions")
			@comments=ClaimAuditEntry.where(:claim=>@claim).first.claim_audit_comments
		end
	end
	# Comment history page
	def comment_history
		if params[:comment_new_review]
			@comment=ClaimAuditComment.create(:comment=>params[:comment_new_review],:claim_audit_entry_id=>params[:claim_id])
		end
		respond_to do |format|
			if @comment.save
				flash[:notice]="Congratulations! your comment is saved"
				format.html{redirect_to root_path}
			else
				flash[:notice]=@comment.errors
				format.html{redirect_to root_path}
			end	
		end   
	end
	# Find reviewer and estimator name
	def find_reviewer_and_estimator(reviewer_id,estimator_id)
		employee_review=Employee.where(:id=>reviewer_id).first
		employee_estimator=Employee.where(:id=>estimator_id.to_i).first
		unless employee_review.blank?
			@reviewer= "#{employee_review.first_name} #{employee_review.last_name}"
		end	
		unless employee_estimator.blank?
			@estimator= "#{employee_estimator.first_name} #{employee_estimator.last_name}"
		end		
	end
end
